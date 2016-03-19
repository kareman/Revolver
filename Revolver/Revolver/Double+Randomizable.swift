extension Double: Randomizable {
    public init(generator: EntropyGenerator) {
        self = generator.next()
    }
}
