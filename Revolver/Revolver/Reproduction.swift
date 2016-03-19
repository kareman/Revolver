
public class Reproduction<Chromosome: Randomizable>: GeneticOperator<Chromosome> {
    
    override public func apply(selectedIndividuals: Selection.IndexSet, pool: PopulationPool<Chromosome>) {
        // Clone selected individuals.
        let clones = selectedIndividuals.map { pool.cloneIndividual($0) }
        
        // Insert clones into new population.
        for clone in clones {
            pool.addIndividualToNextGeneration(clone)
        }
    }
    
}
