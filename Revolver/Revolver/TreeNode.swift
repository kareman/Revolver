
/// Base class for a tree data structure, which can be randomly generated.
///
/// When creating subclasses of this class, feel free to add as many properties as you wish. The only rule is that all
/// properties which are descendant nodes of the current node must be also referenced in the `descendants` array. This
/// array is used for quick enumeration and random generation and if there were any disconnects between its contents and
/// the real state of the data structure, other algorithms working with the tree might produce undefined results.
public class TreeNode: TreeType {
    
    /// Next-level descendant nodes of this node, not necessarily of the same type.
    public var descendants: [TreeType]
    
    /**
     Initialize new random subtree with maximum depth.
     
     - parameter generator: Provider of randomness.
     - parameter policy:    Random generation policy.
     - parameter depth:     Maximum depth of the subtree radiating from this node. If not provided, defaults to the policy.
     
     - returns: New random subtree.
     */
    public required init(generator: EntropyGenerator, policy: TreeRandomizationPolicy, depth: Int? = nil) {
        self.descendants = []
        self.addRandomDescendants(generator, policy: policy, depth: depth)
    }
    
    /**
     Adds random descendants to the node.
     
     - parameter generator: Provider of randomness.
     - parameter policy:    Random generation policy.
     - parameter depth:     Maximum depth used to balance the subtree. If not provided, defaults to the policy.
     - warning: This method is abstract and *must* be implemented in a subclass.
     */
    public func addRandomDescendants(generator: EntropyGenerator, policy: TreeRandomizationPolicy, depth: Int? = nil) {
        preconditionFailure("This method must be overridden in a subclass.")
    }
    
}
