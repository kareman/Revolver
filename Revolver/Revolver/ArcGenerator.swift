
/// Pseudorandom generator based on the standard arc4random() function.
open class ArcGenerator: EntropyGenerator {
    fileprivate static let maxDouble = Double(UINT32_MAX)
    
    public init() { }
    
    open func next() -> Double {
        return Double(arc4random()) / ArcGenerator.maxDouble
    }
}
