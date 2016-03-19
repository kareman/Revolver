extension Float: Randomizable {
    public init(generator: EntropyGenerator) {
        // Loss of precision ahead.
        self = Float(generator.next())
    }
}
