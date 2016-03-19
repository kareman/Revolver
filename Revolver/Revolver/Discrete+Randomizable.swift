extension Discrete {
    // All discrete types are also randomizable.
    public init(generator: EntropyGenerator) {
        let count = Self.allValues.count
        precondition(count > 0, "There has to be at least one value in the allValues array.")
        
        let random = generator.nextInRange(min: 0, max: count - 1)
        self = Self.allValues[random]
    }
}
