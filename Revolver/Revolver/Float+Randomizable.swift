extension Float: Randomizable {
    public static func random(generator: EntropyGenerator) -> Float {
        // Loss of precision ahead.
        return Float(generator.next())
    }
}
