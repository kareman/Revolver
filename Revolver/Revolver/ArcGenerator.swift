/// Pseudorandom generator based on the standard arc4random() function.
public class ArcGenerator: EntropyGenerator {
    private static let maxDouble = Double(UINT32_MAX)
    
    public func next() -> Double {
        return Double(arc4random()) / ArcGenerator.maxDouble
    }
}
