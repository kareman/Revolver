extension EntropyGenerator {
    /**
     Generates new value of any randomizable type.
     
     - returns: New pseudorandom value.
     */
    public func next<T: Randomizable>() -> T {
        return T(generator: self)
    }
}
