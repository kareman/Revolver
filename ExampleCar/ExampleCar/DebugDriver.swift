
class DebugDriver: CarDriver {
    
    func drive(data: CarDetectorMeasurements) -> CarControlParameters {
        // Print detector read-out.
        if data.back || data.under || data.frontLeft || data.frontMiddle || data.frontRight {
            print("\(data.frontLeft ? 1 : 0)\(data.frontMiddle ? 1 : 0)\(data.frontRight ? 1 : 0)\t\t\(data.under ? 1 : 0)\t\t\(data.back ? 1 : 0)    <--- IT'S SOMETHING")
        } else {
            print("000\t\t0\t\t0")
        }
        
        // Return neutral control parameters.
        return CarControlParameters.neutral
    }
    
}
