public class GeneticOperator<Chromosome: Randomizable> {
    public private(set) var entropyGenerator: EntropyGenerator
    
    public init(generator: EntropyGenerator) {
        self.entropyGenerator = generator
    }
    
    public func apply(selectedIndividuals: Selection.IndexSet, pool: PopulationPool<Chromosome>) {
        preconditionFailure("This method must be overridden in a subclass.")
    }
}
