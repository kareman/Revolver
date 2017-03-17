
/// Reproduction copies individuals across generations, while maintaining their chromosome values without alteration.
open class Reproduction<Chromosome: Reproducible>: GeneticOperator<Chromosome> {
    
    open let numberOfIndividuals: Int
    
    public init(_ selection: Selection<Chromosome>, numberOfIndividuals: Int = 1) {
        self.numberOfIndividuals = numberOfIndividuals
        super.init(selection)
    }
    
    open override func apply(_ generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        // Select some individuals.
        let selectedIndividuals = selection.select(generator, population: pool, numberOfIndividuals: numberOfIndividuals)
        
        // Clone selected individuals.
        let clones = selectedIndividuals.map { Individual(original: pool.individualAtIndex($0)) }
        
        // Insert clones into new population.
        for clone in clones {
            pool.addOffspring(clone)
        }
    }
    
}
