
typealias CarDetectorOutput = Bool

struct CarDetectorMeasurements {
    
    let frontLeft: CarDetectorOutput
    let frontMiddle: CarDetectorOutput
    let frontRight: CarDetectorOutput
    
    let under: CarDetectorOutput
    
    let back: CarDetectorOutput
    
}
