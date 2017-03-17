
/// A termination condition decides when to stop a genetic algorithm.
///
/// This class is **abstract**, you cannot instantiate it directly.
/// When overriding it, you will need to subclass the `shouldTerminate()` function.
open class TerminationCondition<Chromosome: ChromosomeType> {
    
    public init() { }
    
    /**
     Decide whether to terminate a genetic algorithm.
     
     - parameter population: Current state of the population.
     
     - returns: True whether the algorithm should be terminated.
     - warning: This method is abstract. You **must** override it in a subclass.
     */
    open func shouldTerminate(_ population: MatingPool<Chromosome>) -> Bool {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
