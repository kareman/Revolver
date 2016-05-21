import Foundation
import Revolver

class CarSimulation {
    
    // The origin is bottom left.
    // The car looks like this:
    
    /*
     y
     |   1     2     3
     |
     |    XXXXXXXXXXX
     |    X         X
     |    X         X
     |    X         X
     |    X    4    X
     |    X         X
     |    X         X
     |    X         X
     |    X         X
     |    XXXXXXXXXXX
     |
     |         5
     |
     0------------------------ x
     
     X. Car's border
     0. Origin of the coordinate system
     1. Front left detector
     2. Front middle detector
     3. Front right detector
     4. Under detector
     5. Back detector
     */
    
    // Car parameters are based on 2010 Audi R8 5.2 V 10 FSI Quattro
    // Assuming: 0-60 in 2.7s, mass 1725kg
    
    static let carDimensions = NSSize(width: 1.930, height: 4.435) // meters
    static let carMinAcceleration = Double(-1) // meters per second per second
    static let carMaxAcceleration = Double(6.17) // meters per second per second
    
    static let samplingPeriod = NSTimeInterval(0.025) // 1/40 seconds (40 Hz)
    
    static let minInitialVelocity = Double(1.38) // 5 km/h
    static let maxInitialVelocity = Double(5.55) // 20 km/h
    static let minVelocity = Double(-5.55) // -20 km/h
    static let maxVelocity = Double(55.55) // 200 km/h
    
    static let steeringAngle = Double(M_PI_4) // In radians.
    
    static let epsilon = Double(1e-5)
    
    // Detector positions with respect to the car's middle point.
    static let frontMiddleDetectorPosition = NSPoint(x: 0, y: 3.2175)
    static let frontLeftDetectorPosition = NSPoint(x: -0.965, y: 3.2175)
    static let frontRightDetectorPosition = NSPoint(x: 0.965, y: 3.2175)
    static let underDetectorPosition = NSPoint(x: 0, y: 0)
    static let backDetectorPosition = NSPoint(x: 0, y: -3.2175)
    
    static let environmentSize = NSSize(width: 10_000, height: 10_000) // 10km x 10km
    static let environmentRect = NSRect(origin: NSPoint.zero, size: CarSimulation.environmentSize)
    static let trackMargin = CGFloat(1_000) // 1 km
    static let trackWidth = CGFloat(5) // 5 m
    
    // Simulation parameters.
    var controlProgram: CarDriver!
    
    // Track to drive on.
    var track: NSBezierPath?
    
    // Metric parameters.
    var lastEvaluatedTime: Double // In seconds.
    var carCenterPoint: NSPoint
    var carOrientation: Double // In radians.
    var carVelocity: Double // In the forward direction after rotation.
    var currentDistance: Double // In meters.
    var currentDistanceSpentOnTrack: Double // In meters.
    
    // Configuration.
    let verbose: Bool
    
    init(verbose: Bool = false) {
        // Place the car in the middle facing north with no velocity.
        self.carCenterPoint = NSPoint(x: CarSimulation.environmentSize.width / 2.0, y: CarSimulation.environmentSize.height / 2.0)
        self.carOrientation = 0
        self.carVelocity = 0
        self.lastEvaluatedTime = 0
        self.currentDistance = 0
        self.currentDistanceSpentOnTrack = 0
        self.track = nil
        self.verbose = verbose
    }
    
    func reset() {
        // Place the car in the middle facing north with no velocity.
        carCenterPoint = NSPoint(x: CarSimulation.environmentSize.width / 2.0, y: CarSimulation.environmentSize.height / 2.0)
        carOrientation = 0
        carVelocity = 0
        lastEvaluatedTime = 0
        track = nil
        currentDistance = 0
        currentDistanceSpentOnTrack = 0
    }
    
    func randomizeTrack(generator: EntropyGenerator) {
        // Generate 30 to 50 random points.
        let pointNumber: Int = generator.nextInRange(30...50)
        var randomPoints = [CGPoint]()
        for _ in 1...pointNumber {
            let x: Double = generator.nextInRange(min: Double(CarSimulation.trackMargin), max: Double(CarSimulation.environmentSize.width - CarSimulation.trackMargin))
            let y: Double = generator.nextInRange(min: Double(CarSimulation.trackMargin), max: Double(CarSimulation.environmentSize.height - CarSimulation.trackMargin))
            
            randomPoints.append(CGPoint(x: x, y: y))
        }
        
        // Sort them.
        randomPoints.sortInPlace { $0.x < $1.x }
        
        // Turn them into a closed curve.
        let hull = convexHull(randomPoints)
        let unstruckPath = NSBezierPath(catmullRomInterpolatedPoints: hull, closed: true, alpha: 0.5)!
        let struckCGPath = CGPathCreateCopyByStrokingPath(unstruckPath.toCGPath()!, nil, CarSimulation.trackWidth, .Butt, .Bevel, 0)
        track = NSBezierPath(CGPath: struckCGPath)
    }
    
    func randomizeCar(generator: EntropyGenerator) {
        // Place the car in the middle facing in random direction with random velocity.
        carCenterPoint = NSPoint(x: CarSimulation.environmentSize.width / 2.0, y: CarSimulation.environmentSize.height / 2.0)
        carVelocity = generator.nextInRange(min: CarSimulation.minInitialVelocity, max: CarSimulation.maxInitialVelocity)
        carOrientation = generator.nextInRange(min: -M_PI, max: M_PI)
    }
    
    func retrieveControlParameters(measurements: CarDetectorMeasurements) -> CarControlParameters {
        guard let driver = controlProgram else {
            print("WARNING: CarSimulation running with no CarDriver specified.")
            return CarControlParameters.neutral
        }
        
        // Ask the driver what to do.
        let controls = driver.drive(measurements)
        
        // Make sure the acceleration is within car's parameters.
        let clampedAcceleration = min(max(controls.acceleration, CarSimulation.carMinAcceleration), CarSimulation.carMaxAcceleration)
        return CarControlParameters(steering: controls.steering, acceleration: clampedAcceleration)
    }
    
    func eventLoop(time: NSTimeInterval) {
        let deltaTime = time - lastEvaluatedTime
        guard deltaTime > CarSimulation.epsilon else {
            return
        }
        
        // Poll detectors.
        let detectors = currentDetectorMeasurements
        
        // Retrieve control parameters.
        let controlParams = retrieveControlParameters(detectors)
        
        // Update velocity & orientation.
        carVelocity += deltaTime * controlParams.acceleration
        carVelocity = max(min(carVelocity, CarSimulation.maxVelocity), CarSimulation.minVelocity)
        
        switch controlParams.steering {
        case .HardLeft: carOrientation += 2 * CarSimulation.steeringAngle
        case .Left: carOrientation += CarSimulation.steeringAngle
        case .Right: carOrientation -= CarSimulation.steeringAngle
        case .HardRight: carOrientation -= 2 * CarSimulation.steeringAngle
        default: break
        }
        
        if carOrientation > M_2_PI {
            carOrientation -= M_2_PI
        } else if carOrientation < -M_2_PI {
            carOrientation += M_2_PI
        }
        
        // Update car position.
        let transform = currentCarTransform
        let distance = deltaTime * carVelocity
        let translation = NSPoint(x: 0, y: distance)
        let translationTransformed = transform.transformPoint(translation)
        
        carCenterPoint.x += translationTransformed.x
        carCenterPoint.y += translationTransformed.y
        
        currentDistance += distance
        
        if isCarOnTrack {
            currentDistanceSpentOnTrack += distance
        }
        
        lastEvaluatedTime = time
    }
    
    func readDetector(position: NSPoint) -> CarDetectorOutput {
        guard let curve = track else {
            print("WARNING: CarSimulation running without a track.")
            return false
        }
        
        let transform = currentCarTransform
        let positionTransformed = transform.transformPoint(position)
        
        var currentDetectorPosition = carCenterPoint
        currentDetectorPosition.x += positionTransformed.x
        currentDetectorPosition.y += positionTransformed.y
        
        // Compare the position of the detector with the track.
        return curve.containsPoint(currentDetectorPosition)
    }
    
    var isCarWithinBounds: Bool {
        return CarSimulation.environmentRect.contains(carCenterPoint)
    }
    
    var isCarOnTrack: Bool {
        return readDetector(CarSimulation.underDetectorPosition)
    }
    
    var currentDetectorMeasurements: CarDetectorMeasurements {
        return CarDetectorMeasurements(
            frontLeft: readDetector(CarSimulation.frontLeftDetectorPosition),
            frontMiddle: readDetector(CarSimulation.frontMiddleDetectorPosition),
            frontRight: readDetector(CarSimulation.frontRightDetectorPosition),
            under: readDetector(CarSimulation.underDetectorPosition),
            back: readDetector(CarSimulation.backDetectorPosition)
        )
    }
    
    var currentCarTransform: NSAffineTransform {
        let transform = NSAffineTransform()
        transform.rotateByRadians(CGFloat(carOrientation))
        return transform
    }
    
    func run(maxDuration maxDuration: NSTimeInterval) -> CarSimulationOutcome {
        var currentTime = NSTimeInterval(0)
        var currentTimeSpentOnTrack = NSTimeInterval(0)
        
        currentDistance = 0
        currentDistanceSpentOnTrack = 0
        
        if verbose {
            print("% This is duration of a single simulation step in seconds.")
            print("samplingPeriod = \(CarSimulation.samplingPeriod);\n")
            
            print("% Simulation data.")
            
            let maxSteps = Int(ceil(maxDuration / CarSimulation.samplingPeriod))
            
            print("time = zeros(1,\(maxSteps)); % seconds")
            print("x = zeros(1,\(maxSteps)); % meters (origin bottom left)")
            print("y = zeros(1,\(maxSteps)); % meters (origin bottom left)")
            print("rotation = zeros(1,\(maxSteps)); % radians from driver's viewport")
            print("velocity = zeros(1,\(maxSteps)); % meters per seconds in driving direction\n")
            
            if let t = track {
                print("trackx = zeros(1,\(t.elementCount));")
                print("tracky = zeros(1,\(t.elementCount));")
                var points = [NSPoint](count: 3, repeatedValue: NSPoint.zero)
                for i in 0..<t.elementCount {
                    let _ = t.elementAtIndex(i, associatedPoints: &points)
                    if let p = points.first {
                        print("trackx(\(i + 1)) = \(p.x);\t tracky(\(i + 1)) = \(p.y);")
                    } else {
                        print("trackx(\(i + 1)) = 0;\t tracky(\(i + 1)) = 0;")
                    }
                }
            }
        }
        
        lastEvaluatedTime = 0
        
        var step = 1
        while currentTime < maxDuration && isCarWithinBounds {
            if verbose {
                // Print simulation info.
                print("time(\(step)) = \(currentTime);\t x(\(step)) = \(carCenterPoint.x);\t y(\(step)) = \(carCenterPoint.y);\t rotation(\(step)) = \(carOrientation);\t velocity(\(step)) = \(carVelocity);")
                step += 1
            }
            
            eventLoop(currentTime)
            currentTime += CarSimulation.samplingPeriod
            
            if isCarOnTrack {
                currentTimeSpentOnTrack += CarSimulation.samplingPeriod
            }
        }
        
        if verbose {
            print("animationSpeed = 5; % the animation coefficient")
            print("frequency = animationSpeed / samplingPeriod;")
            print("h = animatedline;")
            print("axis([0,\(CarSimulation.environmentSize.width),0,\(CarSimulation.environmentSize.height)])\n")
            
            print("for k = 1:frequency:length(x)")
            print("    addpoints(h,x(k),y(k));")
            print("    drawnow");
            print("end\n")
        }
        
        let outcome = CarSimulationOutcome(
            carLeftBounds: !isCarWithinBounds,
            duration: currentTime,
            timeSpentOnTrack: currentTimeSpentOnTrack,
            distanceTraveled: currentDistance,
            distanceTraveledOnTrack: currentDistanceSpentOnTrack
        )
        
        if verbose {
            print("% Outcome: \(outcome)")
            print("% If the simulation ended prematurely, be sure to change the array dimensions to get better performance.")
        }
        
        return outcome
    }
    
}
