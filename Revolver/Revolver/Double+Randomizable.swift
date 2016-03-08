extension Double: Randomizable {
    public static func random(generator: EntropyGenerator) -> Double {
        return generator.next()
    }
}
