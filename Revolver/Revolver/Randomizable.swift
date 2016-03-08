/**
 *  A randomizable type can be generated pseudorandomly using entropy generator.
 */
public protocol Randomizable {
    /**
     Generate a new random value of this type.
     
     - parameter generator: Provider of randomness.
     
     - returns: New random value.
     */
    static func random(generator: EntropyGenerator) -> Self
}
