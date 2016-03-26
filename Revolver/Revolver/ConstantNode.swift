
/// Constant node represents any hardcoded randomizable value.
public final class ConstantNode<ValueType: Randomizable>: ValueNode<ValueType> {
    
    /// Value of the constant.
    public var constant: ValueType
    
    /**
     Adds random descendants to the node.
     
     - parameter generator: Provider of randomness.
     - parameter policy:    Random generation policy.
     - parameter depth:     Maximum depth used to balance the subtree. If not provided, defaults to the policy.
     */
    public override func addRandomDescendants(generator: EntropyGenerator, policy: TreeRandomizationPolicy, depth: Int?) {
        // Constant nodes have no descendants, duh.
    }    
    
    
    /**
     Initialize new random subtree with maximum depth.
     
     - parameter generator: Provider of randomness.
     - parameter policy:    Random generation policy.
     - parameter depth:     Maximum depth of the subtree radiating from this node. If not provided, defaults to the policy.
     
     - returns: New random subtree.
     */
    public required init(generator: EntropyGenerator, policy: TreeRandomizationPolicy, depth: Int?) {
        self.constant = generator.next()
        super.init(generator: generator, policy: policy, depth: depth)
    }
    
}
