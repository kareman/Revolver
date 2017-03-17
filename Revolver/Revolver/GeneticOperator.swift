
/// A genetic operator randomly interacts with the genome of individuals.
///
/// This class is **abstract**, you cannot instantiate it directly.
/// When subclassing it, be sure to implement the `apply()` method.
open class GeneticOperator<Chromosome: ChromosomeType> {
    
    internal let selection: Selection<Chromosome>
    
    public init(_ selection: Selection<Chromosome>) {
        self.selection = selection
    }

    /**
     Applies the operator on some individuals within a population pool.
     
     - parameter selectedIndividuals: Indices of selected individuals.
     - parameter pool:                Pool of individuals. This object is guaranteed to be in the staging state.
     - warning: This method is abstract and *must* be implemented in a subclass.
     */
    open func apply(_ generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
