extension Discrete {
    // All discrete types are also randomizable.
    public static func random(generator: EntropyGenerator) -> Self {
        let count = Self.allValues.count
        precondition(count > 0, "There has to be at least one value in the allValues array.")
        
        let random = generator.nextInRange(min: 0, max: count - 1)
        return Self.allValues[random]
    }
}
