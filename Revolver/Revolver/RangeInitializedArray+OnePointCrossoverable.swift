
extension RangeInitializedArray: OnePointCrossoverable {
    
    public func onePointCrossover(generator: EntropyGenerator, other: RangeInitializedArray) -> (first: RangeInitializedArray, second: RangeInitializedArray) {
        // Propagate crossover to underlying arrays.
        let subCrossover = self.array.onePointCrossover(generator, other: other.array)
        
        // Initialize new arrays on top of the results.
        let firstOffspring = RangeInitializedArray(array: subCrossover.first)
        let secondOffspring = RangeInitializedArray(array: subCrossover.second)
        
        return (first: firstOffspring, second: secondOffspring)
    }
    
}
