/**
 *  Generator of pseudorandom values.
 */
public protocol EntropyGenerator {
    /**
     Generates new pseudorandom floating point-value.
     
     - returns: Decimal number between zero and one.
     */
    func next() -> Double
}
