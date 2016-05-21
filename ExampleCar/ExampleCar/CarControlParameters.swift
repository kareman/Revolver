
enum CarSteering {
    
    case HardLeft
    case Left
    case Neutral
    case Right
    case HardRight
    
}

struct CarControlParameters {
    
    let steering: CarSteering
    let acceleration: Double
    
    static let neutral = CarControlParameters(steering: .Neutral, acceleration: 0)
    
}
