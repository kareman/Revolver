
/// Select random individuals from the population. No regards is given to their fitness.
public class RandomSelection<Chromosome: ChromosomeType>: Selection<Chromosome> {
    
    public override init() { }
    
    public override func select(generator: EntropyGenerator, population: MatingPool<Chromosome>, numberOfIndividuals: Int) -> IndexSet {
        precondition(numberOfIndividuals <= population.populationSize, "The number of individuals to select is greater than the number of individuals available.")

        var indices = IndexSet()
        indices.append(generator.nextInRange(min: 0, max: population.populationSize - 1))
        return indices
    }
    
}
