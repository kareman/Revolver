
/// Select N worst individuals according to their fitness.
public class WorstSelection<Chromosome: ChromosomeType>: Selection<Chromosome> {
    
    public override init() { }
    
    public override func select(generator: EntropyGenerator, population: MatingPool<Chromosome>, numberOfIndividuals: Int) -> IndexSet {
        precondition(numberOfIndividuals <= population.populationSize, "The number of individuals to select is greater than the number of individuals available.")
        
        let bestIndices = population.populationIndicesSortedByFitness[0..<numberOfIndividuals]
        return IndexSet(bestIndices)
    }
    
}
