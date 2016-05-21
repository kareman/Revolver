
class NetDriver: CarDriver {
    
    let net: FFNN
    
    init(net: FFNN) {
        precondition(net.numInputs == 5, "The neural network must have exactly 5 inputs.")
        precondition(net.numOutputs == 2, "The neural network must have exactly 2 outputs.")
        
        self.net = net
    }
    
    private func translateDetectorSignal(flag: CarDetectorOutput) -> Float {
        return flag ? 1.0 : 0.0
    }
    
    func drive(data: CarDetectorMeasurements) -> CarControlParameters {
        // Prepare input signals from the detector measurements.
        let inputSignals: [Float] = [
            translateDetectorSignal(data.frontLeft),
            translateDetectorSignal(data.frontMiddle),
            translateDetectorSignal(data.frontRight),
            translateDetectorSignal(data.under),
            translateDetectorSignal(data.back)
        ]
        
        // Propagate signal through the neural network.
        guard let outputSignals = try? net.update(inputs: inputSignals) else {
            // Error occured.
            print("WARNING: NetDriver encountered error when propagating signals through neural network.")
            return CarControlParameters.neutral
        }
        
        // Read control parameters.
        let steeringSignal = outputSignals[0]
        let accelerationSignal = outputSignals[1]
        
        let steering: CarSteering
        
        // Emulate this axis behavior:
        
        // 0                      0.1                0.3                   0.7                 0.9                       1
        // <------ HARD LEFT ------|------ LEFT ------|------ NEUTRAL ------|------ RIGHT ------|------ HARD RIGHT ------>
        
        if 0.3 < steeringSignal && steeringSignal <= 0.7 {
            steering = .Neutral
        } else if 0.1 < steeringSignal && steeringSignal <= 0.3 {
            steering = .Left
        } else if 0.7 < steeringSignal && steeringSignal <= 0.9 {
            steering = .Right
        } else if steeringSignal <= 0.1 {
            steering = .HardLeft
        } else {
            steering = .HardRight
        }
        
        return CarControlParameters(steering: steering, acceleration: Double(accelerationSignal))
    }
    
}
