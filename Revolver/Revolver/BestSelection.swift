
/// Select N best individuals according to their fitness.
open class BestSelection<Chromosome: ChromosomeType>: Selection<Chromosome> {
    
    public override init() { }
    
    open override func select(_ generator: EntropyGenerator, population: MatingPool<Chromosome>, numberOfIndividuals: Int) -> IndexSet {
        precondition(numberOfIndividuals <= population.populationSize, "The number of individuals to select is greater than the number of individuals available.")
        
        let bestIndices = population.populationIndicesSortedByFitness.dropFirst(population.populationSize - numberOfIndividuals)
        return IndexSet(bestIndices)
    }
    
}
