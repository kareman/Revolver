
extension RangeInitializedArray {

    public func onePointCrossover(generator: EntropyGenerator, other: Self) -> (first: Self, second: Self) {
        // Propagate crossover to underlying arrays.
        let subCrossover = self.array.onePointCrossover(generator, other: other.array)

        // Initialize new arrays on top of the results.
        let firstOffspring = Self(array: subCrossover.first)
        let secondOffspring = Self(array: subCrossover.second)

        return (first: firstOffspring, second: secondOffspring)
    }

}
