extension Bool: Randomizable {
    public init(generator: EntropyGenerator) {
        self = generator.next() > 0.5
    }
}
