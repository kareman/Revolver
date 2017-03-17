
/// Select N worst individuals according to their fitness.
open class WorstSelection<Chromosome: ChromosomeType>: Selection<Chromosome> {
    
    public override init() { }
    
    open override func select(_ generator: EntropyGenerator, population: MatingPool<Chromosome>, numberOfIndividuals: Int) -> IndexSet {
        precondition(numberOfIndividuals <= population.populationSize, "The number of individuals to select is greater than the number of individuals available.")
        
        let bestIndices = population.populationIndicesSortedByFitness[0..<numberOfIndividuals]
        return IndexSet(bestIndices)
    }
    
}
