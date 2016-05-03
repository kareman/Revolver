
/// Select N best individuals according to their fitness.
public class BestSelection<Chromosome: Randomizable>: Selection<Chromosome> {
    
    public override func select(generator: EntropyGenerator, population: MatingPool<Chromosome>, numberOfIndividuals: Int) -> IndexSet {
        precondition(numberOfIndividuals >= population.populationSize, "The number of individuals to select is greater than the number of individuals available.")
        
        let bestIndices = population.populationIndicesSortedByFitness.dropFirst(population.populationSize - numberOfIndividuals)
        return IndexSet(bestIndices)
    }
    
}
