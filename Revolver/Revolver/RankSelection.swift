
/// Another fitness-proportional selection method, fundamentally similar to `RouletteSelection`.
///
/// Considering ranks instead of actual fitness values, this method proves to be more robust when marginal
/// or ill-determined fitness values are expected.
open class RankSelection<Chromosome: ChromosomeType>: Selection<Chromosome> {
    
    public override init() { }
    
    /**
     Finds index of an interval containing a specific value on the roulette wheel.
     
     - parameter roulette:   Value on the wheel.
     - parameter population: Population with weights of intervals determined by the fitness.
     
     - returns: Index of the interval, where the value belongs.
     */
    fileprivate func findIndexOnWheel(_ roulette: Double, population: MatingPool<Chromosome>) -> Int {
        var incrementalWeight = Double(0)
        
        for index in 0..<population.populationSize {
            let individualWeight = Double(index + 1)
            
            // Cumulatively add weights and find the interval index, where the roulette struck.
            let newWeight = incrementalWeight + individualWeight
            
            if roulette >= incrementalWeight && roulette < newWeight {
                // If the generated value belongs to this interval, return its index.
                return population.populationIndicesSortedByFitness[index]
            }
            
            incrementalWeight = newWeight
        }
        
        // Fallback for roulette == 1.
        return population.populationIndicesSortedByFitness.last!
    }
    
    open override func select(_ generator: EntropyGenerator, population: MatingPool<Chromosome>, numberOfIndividuals: Int) -> IndexSet {
        precondition(numberOfIndividuals <= population.populationSize, "The number of individuals to select is greater than the number of individuals available.")
        
        // Sum of arithmetic series.
        let weightsSum = Double(population.populationSize) * (1 + Double(population.populationSize)) / 2.0
        
        var foundIndexSet = IndexSet()
        for _ in 0..<numberOfIndividuals {
            // Spin the roulette.
            let roulette: Double = generator.nextInRange(min: 0, max: weightsSum)
            let foundIndex = findIndexOnWheel(roulette, population: population)
            
            // Add the index corresponding to the selected interval.
            foundIndexSet.append(foundIndex)
        }
        
        return foundIndexSet
    }

}
