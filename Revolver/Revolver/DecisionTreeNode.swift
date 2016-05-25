
/// A decision tree describes a chained series of actions applied in sequence on a population.
public class DecisionTreeNode<Chromosome: ChromosomeType> {
    
    /// The next node in the sequence.
    private var next: DecisionTreeNode<Chromosome>?
    
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
    public func execute(generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        guard let op = next else { return }
        op.execute(generator, pool: pool)
    }
    
    /**
     Set next node in the sequence.
     
     - parameter next: The new value of `next`.
     */
    public func chain(next: DecisionTreeNode<Chromosome>) {
        self.next = next
    }
    
}
