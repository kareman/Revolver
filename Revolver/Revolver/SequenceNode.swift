
/// Sequence node represents a set of actions which are to be executed in specific order.
public final class SequenceNode: ActionNode {
    
    /// The ordered sequence of actions.
    public var sequence = [ActionNode]()
    
    /**
     Adds random descendants to the node.
     
     - parameter generator: Provider of randomness.
     - parameter policy:    Random generation policy.
     - parameter depth:     Maximum depth used to balance the subtree. If not provided, defaults to the policy.
     - warning: This method is abstract and *must* be implemented in a subclass.
     */
    public override func addRandomDescendants(generator: EntropyGenerator, policy: TreeRandomizationPolicy, depth: Int?) {
        let maxDepth = depth ?? policy.maximumDepth
        guard maxDepth > 0 else {
            // We have reached a terminal node, hence there will be no descendants.
            return
        }
        
        // Randomly determine number of descendants.
        let width = generator.nextInRange(min: 0, max: policy.maximumWidth)
        
        // Reserve memory to minimize overhead.
        sequence.reserveCapacity(width)
        descendants.reserveCapacity(width)
        
        for _ in 0..<width {
            // Generate some random descendants.
            let descendant = policy.createRandomAction(generator, policy: policy, depth: maxDepth - 1)
            
            // Add them to the stack.
            sequence.append(descendant)
            descendants.append(descendant)
        }
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
