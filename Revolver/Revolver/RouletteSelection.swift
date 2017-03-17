
/// Roulette selection is a simple fitness-proportional selection method.
open class RouletteSelection<Chromosome: ChromosomeType>: Selection<Chromosome> {
    
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
            // Cumulatively add weights and find the interval index, where the roulette struck.
            let newWeight = incrementalWeight + population.individualAtIndex(index).fitness!
            
            if roulette >= incrementalWeight && roulette < newWeight {
                // If the generated value belongs to this interval, return its index.
                return index
            }
            
            incrementalWeight = newWeight
        }
        
        // Fallback for roulette == 1.
        return population.populationSize - 1
    }
    
    open override func select(_ generator: EntropyGenerator, population: MatingPool<Chromosome>, numberOfIndividuals: Int) -> IndexSet {
        precondition(numberOfIndividuals <= population.populationSize, "The number of individuals to select is greater than the number of individuals available.")
        
        // Maximum of the random generation.
        let weightsSum = population.fitnessSum
        
        var foundIndexSet = IndexSet()
        for _ in 0..<numberOfIndividuals {
            let foundIndex: Int
            
            if weightsSum >= REVOLVER_EPSILON {
                // Spin the roulette.
                let roulette: Double = generator.nextInRange(min: 0, max: weightsSum)
                foundIndex = findIndexOnWheel(roulette, population: population)
            } else {
                // If the sum is zero, roulette selection behaves uniformly.
                foundIndex = generator.nextInRange(min: 0, max: population.populationSize - 1)
            }
            
            // Add the index corresponding to the selected interval.
            foundIndexSet.append(foundIndex)
        }
        
        return foundIndexSet
    }
    
}
