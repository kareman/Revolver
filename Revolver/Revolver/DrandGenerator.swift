
/// Pseudorandom generator based on the standard drand48() function.
public class DrandGenerator: EntropyGenerator {
    public init() { }
    
    public func next() -> Double {
        return drand48()
    }
}
