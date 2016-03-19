
public protocol OnePointCrossoverable {
    func onePointCrossover(generator: EntropyGenerator, other: Self) -> (first: Self, second: Self)
}

public class OnePointCrossover<Chromosome where Chromosome: Randomizable, Chromosome: OnePointCrossoverable>: GeneticOperator<Chromosome> {
    
    override public func apply(selectedIndividuals: Selection.IndexSet, pool: PopulationPool<Chromosome>) {
        precondition(selectedIndividuals.count == 2, "The selectedIndividuals argument must contain exactly 2 indices.")

        // Retrieve parent chromosomes.
        let firstChromosome = pool.retrieveChromosome(selectedIndividuals.first!)
        let secondChromosome = pool.retrieveChromosome(selectedIndividuals.last!)
        
        // Perform crossover on their underlying data structure.
        let result = firstChromosome.onePointCrossover(entropyGenerator, other: secondChromosome)
        
        // Insert the offspring into new population.
        let firstOffspring = Individual<Chromosome>(chromosome: result.first)
        let secondOffspring = Individual<Chromosome>(chromosome: result.second)
        
        pool.addIndividualToNextGeneration(firstOffspring)
        pool.addIndividualToNextGeneration(secondOffspring)
    }
    
}
