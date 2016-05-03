
/// One-point crossover simulates sexual reproduction of individuals within the population.
/// It combines their chromosomes to create new offspring chromosomes, which are then inserted into the next generation.
public class OnePointCrossover<Chromosome where Chromosome: Randomizable, Chromosome: OnePointCrossoverable>: GeneticOperator<Chromosome> {
    
    public override init(_ selection: Selection<Chromosome>) {
        super.init(selection)
    }
    
    public override func apply(generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        // Select 2 individuals.
        let selectedIndividuals = selection.select(generator, population: pool, numberOfIndividuals: 2)
        
        // Retrieve parent chromosomes.
        let firstChromosome = pool.individualAtIndex(selectedIndividuals.first!).chromosome
        let secondChromosome = pool.individualAtIndex(selectedIndividuals.last!).chromosome
        
        // Perform crossover on their underlying data structure.
        let result = firstChromosome.onePointCrossover(generator, other: secondChromosome)
        
        // Insert the offspring into new population.
        let firstOffspring = Individual<Chromosome>(chromosome: result.first)
        let secondOffspring = Individual<Chromosome>(chromosome: result.second)
        
        pool.addOffspring(firstOffspring)
        pool.addOffspring(secondOffspring)
    }
    
}
