
/// A decision tree describes a chained series of actions applied in sequence on a population.
open class DecisionTreeNode<Chromosome: ChromosomeType> {
    
    /// The next node in the sequence.
    fileprivate var next: DecisionTreeNode<Chromosome>?
    
    /**
     Create new decision tree node.
     
     - returns: New instance.
     */
    public init() {
        self.next = nil
    }
    
    /**
     Execute the decision tree.
     
     - parameter generator: Provider of randomness.
     - parameter pool:      Population on which to execute the tree.
     */
    open func execute(_ generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        guard let op = next else { return }
        op.execute(generator, pool: pool)
    }
    
    /**
     Set next node in the sequence.
     
     - parameter next: The new value of `next`.
     */
    open func chain(_ next: DecisionTreeNode<Chromosome>) {
        self.next = next
    }
    
}
