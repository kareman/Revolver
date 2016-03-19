
/// A genetic operator randomly interacts with the genome of individuals.
public class GeneticOperator<Chromosome: Randomizable> {
    
    /// The provider of randomness.
    public private(set) var entropyGenerator: EntropyGenerator
    
    /**
     Initializes new instance of a genetic operator.
     
     - parameter generator: Provider of randomness.
     
     - returns: New operator.
     */
    public init(generator: EntropyGenerator) {
        self.entropyGenerator = generator
    }
    
    /**
     Applies the operator on some individuals within a population pool.
     
     - parameter selectedIndividuals: Indices of selected individuals.
     - parameter pool:                Pool of individuals. This object is guaranteed to be in the staging state.
     - warning: This method is abstract and *must* be implemented in a subclass.
     */
    public func apply(selectedIndividuals: Selection.IndexSet, pool: PopulationPool<Chromosome>) {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
