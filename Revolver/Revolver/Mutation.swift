
/**
 *  Type can be slightly non-deterministically altered.
 */
public protocol Mutable {
    
    /**
     Creates new instance by copying values of the current instance and changing them randomly.
     
     - parameter generator: Provider of randomness.
     
     - returns: New mutated instance.
     */
    func mutate(generator: EntropyGenerator) -> Self
    
}

/// Mutation operator introduces diversity in the population by slightly altering its individuals.
public class Mutation<Chromosome where Chromosome: Randomizable, Chromosome: Mutable>: GeneticOperator<Chromosome> {
    
    /**
     Mutates genome of a single individual in the population pool and inserts the resulting mutant into next generation.
     
     - parameter selectedIndividuals: Exactly one index of selected individual.
     - parameter pool:                Pool of individuals. This object is guaranteed to be in the staging state.
     */
    override public func apply(selectedIndividuals: Selection.IndexSet, pool: MatingPool<Chromosome>) {
        precondition(selectedIndividuals.count == 1, "The selectedIndividuals argument must contain exactly 1 index.")
        
        // Retrieve soon-to-be-mutated chromosome.
        let selectedChromosome = pool.individualAtIndex(selectedIndividuals.first!).chromosome
        
        // Perform mutation on its underlying data structure.
        let mutatedChromosome = selectedChromosome.mutate(entropyGenerator)
        
        // Insert mutant into new population.
        let mutant = Individual<Chromosome>(chromosome: mutatedChromosome)
        pool.addOffspring(mutant)
    }
    
}
