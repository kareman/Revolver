
/// Loop node represents a `while` loop. A sequence of actions is performed repeatedly until a termination condition
/// is satisfied.
public final class LoopNode: ActionNode {
    
    /// A logical predicate determining whether the loop will stop repeating.
    public var terminationCondition: ValueNode<Bool>!
    
    /// Sequence of actions to perform while in the loop.
    public var actions: SequenceNode!
    
    public override func addRandomDescendants(generator: EntropyGenerator, policy: TreeRandomizationPolicy, depth: Int?) {
        let maxDepth = depth ?? policy.maximumDepth
        
        terminationCondition = policy.createRandomValue(generator, policy: policy, depth: maxDepth - 1)
        actions = SequenceNode(generator: generator, policy: policy, depth: maxDepth - 1)
        
        descendants.appendContentsOf([terminationCondition, actions] as [TreeType])
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
