
/// Mutation operator introduces diversity in the population by slightly altering its individuals.
open class Mutation<Chromosome: Mutable>: GeneticOperator<Chromosome> {
    
    public override init(_ selection: Selection<Chromosome>) {
        super.init(selection)
    }
    
    open override func apply(_ generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        // Select a single individual.
        let selectedIndividuals = selection.select(generator, population: pool, numberOfIndividuals: 1)
        let selectedIndividual = selectedIndividuals.first!
        
        // Retrieve soon-to-be-mutated chromosome.
        let selectedChromosome = pool.individualAtIndex(selectedIndividual).chromosome
        
        // Perform mutation on its underlying data structure.
        let mutatedChromosome = selectedChromosome.mutate(generator)
        
        // Insert mutant into new population.
        let mutant = Individual<Chromosome>(chromosome: mutatedChromosome)
        pool.addOffspring(mutant)
    }
    
}
