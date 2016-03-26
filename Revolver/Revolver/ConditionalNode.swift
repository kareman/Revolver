
/// Conditional node represents an action depending on a predicate. During interpretation, the predicate is evaluated and
/// the sequence of actions to be performed is selected.
public final class ConditionalNode: ActionNode {
    
    /// Logical condition which determines which actions are performed.
    public var predicate: ValueNode<Bool>!
    
    /// Sequence of actions to be performed in case `predicate` is true.
    public var trueActions: SequenceNode!
    
    /// Sequence of actions to be performed in case `predicate` is false.
    public var falseActions: SequenceNode!
    
    public override func addRandomDescendants(generator: EntropyGenerator, policy: TreeRandomizationPolicy, depth: Int?) {
        let maxDepth = depth ?? policy.maximumDepth
        
        predicate = policy.createRandomValue(generator, policy: policy, depth: maxDepth - 1)
        
        trueActions = SequenceNode(generator: generator, policy: policy, depth: maxDepth - 1)
        falseActions = SequenceNode(generator: generator, policy: policy, depth: maxDepth - 1)
        
        descendants.appendContentsOf([predicate, trueActions, falseActions] as [TreeType])
    }
    
    /**
     Initialize new random subtree with maximum depth.
     
     - parameter generator: Provider of randomness.
     - parameter policy:    Random generation policy.
     - parameter depth:     Maximum depth of the subtree radiating from this node. If not provided, defaults to the policy.
     
     - returns: New random subtree.
     */
    public required init(generator: EntropyGenerator, policy: TreeRandomizationPolicy, depth: Int?) {
        super.init(generator: generator, policy: policy, depth: depth)
    }
    
}
