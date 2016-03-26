
/// Value node represents a scalar or vector value of any type (number, boolean, etc.)
public class ValueNode<ValueType>: TreeNode {
    
    /**
     Initialize new random subtree with maximum depth.
     
     - parameter generator: Provider of randomness.
     - parameter policy:    Random generation policy.
     - parameter depth:     Maximum depth of the subtree radiating from this node. If not provided, defaults to the policy.
     
     - warning: Do not instantiate this class directly. Create various subclasses of it, instead.
     - returns: New random subtree.
     */
    public required init(generator: EntropyGenerator, policy: TreeRandomizationPolicy, depth: Int?) {
        super.init(generator: generator, policy: policy, depth: depth)
    }
    
}
