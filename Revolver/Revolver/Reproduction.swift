
/// Reproduction copies individuals across generations, while maintaining their chromosome values without alteration.
public class Reproduction<Chromosome: Randomizable>: GeneticOperator<Chromosome> {
    
    /**
     Clones some individuals from the population pool and inserts them into the next generation.
     
     - parameter selectedIndividuals: Indices of selected individuals.
     - parameter pool:                Pool of individuals. This object is guaranteed to be in the staging state.
     */
    override public func apply(selectedIndividuals: Selection.IndexSet, pool: PopulationPool<Chromosome>) {
        // Clone selected individuals.
        let clones = selectedIndividuals.map { pool.cloneIndividual($0) }
        
        // Insert clones into new population.
        for clone in clones {
            pool.addIndividualToNextGeneration(clone)
        }
    }
    
}
