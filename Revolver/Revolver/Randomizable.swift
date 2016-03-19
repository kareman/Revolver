/**
 *  A randomizable type can be generated pseudorandomly using entropy generator.
 */
public protocol Randomizable {
    init(generator: EntropyGenerator)
}
