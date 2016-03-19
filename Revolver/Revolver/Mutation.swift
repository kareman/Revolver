
public protocol Mutable {
    func mutate(generator: EntropyGenerator) -> Self
}

public class Mutation<Chromosome where Chromosome: Randomizable, Chromosome: Mutable>: GeneticOperator<Chromosome> {
    
    override public func apply(selectedIndividuals: Selection.IndexSet, pool: PopulationPool<Chromosome>) {
        precondition(selectedIndividuals.count == 1, "The selectedIndividuals argument must contain exactly 1 index.")
        
        // Retrieve soon-to-be-mutated chromosome.
        let selectedChromosome = pool.retrieveChromosome(selectedIndividuals.first!)
        
        // Perform mutation on its underlying data structure.
        let mutatedChromosome = selectedChromosome.mutate(entropyGenerator)
        
        // Insert mutant into new population.
        let mutant = Individual<Chromosome>(chromosome: mutatedChromosome)
        pool.addIndividualToNextGeneration(mutant)
    }
    
}
