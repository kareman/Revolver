extension Bool: Randomizable {
    public static func random(generator: EntropyGenerator) -> Bool {
        return generator.next() > 0.5
    }
}