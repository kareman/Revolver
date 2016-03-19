
/// Another fitness-proportional selection method, fundamentally similar to `RouletteSelection`.
///
/// Considering ranks instead of actual fitness values, this method proves to be more robust when marginal
/// or ill-determined fitness values are expected.
public class RankSelection: RouletteSelection {
    
    // MARK: Implementation of abstract methods.
    
    /**
     This method shall be called when the population pool changes.
     The selection object uses it to update weights on the roulette wheel proportional to the ranks of individuals,
     as sorted by their fitness (greater fitness = greater rank = greater weight).
    
     - parameter population: Population to select from.
                             It is guaranteed that at the time of calling this method, the `fitness` property
                             of all individuals in the population is not equal to `nil`.
     */
    public override func prepareForNewPopulation(population: [FitnessType]) {
        // Sort the indices of the population.
        let indices = 0..<population.count
        let sortedIndices = indices.sort { self.fitnessMapping(population[$0].fitness!) < self.fitnessMapping(population[$1].fitness!) }
        
        // Initialize the weights as ranks in the fitness-proportional ordering.
        currentWeights = [Double](count: population.count, repeatedValue: 0)
        currentWeightsSum = 0
        
        var rank = 1
        for index in sortedIndices {
            // Enumerate the sorted indices from the lowest fitness to the largest.
            currentWeights[index] = Double(rank)
            currentWeightsSum += Double(rank)
            
            // Gradually increase the rank, so that the individual with the largest fitness, ends up with the largest weight.
            ++rank
        }
        
        prepared = true
    }

}
