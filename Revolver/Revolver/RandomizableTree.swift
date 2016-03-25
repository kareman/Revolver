
/// Base class for a tree data structure, which can be randomly generated.
///
/// When creating subclasses of this class, feel free to add as many properties as you wish. The only rule is that all
/// properties which are descendant nodes of the current node must be also referenced in the `descendants` array. This
/// array is used for quick enumeration and random generation and if there were any disconnects between its contents and
/// the real state of the data structure, other algorithms working with the tree might produce undefined results.
public class RandomizableTree: TreeType, Randomizable {
    
    /// Next-level descendant nodes of this node, not necessarily of the same type.
    public var descendants: [TreeType]
    
    /**
     Initialize new random subtree with maximum depth.
     
     - parameter generator: Provider of randomness.
     - parameter maxDepth:  Maximum depth used to balance the subtree, pass in `nil` for the root node.
     
     - returns: New random subtree.
     */
    public required init(generator: EntropyGenerator, maxDepth: Int?) {
        self.descendants = []
        
        if let depth = maxDepth {
            self.addRandomDescendants(generator, maxDepth: depth - 1)
        } else {
            self.addRandomDescendants(generator)
        }
    }
    
    /**
     Initialize new random subtree.
     
     - parameter generator: Provider of randomness.
     
     - returns: New random subtree.
     */
    public required convenience init(generator: EntropyGenerator) {
        self.init(generator: generator, maxDepth: nil)
    }
    
    /**
     Adds random descendants to the node.
     
     - parameter generator: Provider of randomness.
     - parameter maxDepth:  Maximum depth used to balance the subtree, pass in `nil` for the root node.
     - warning: This method is abstract and *must* be implemented in a subclass.
     */
    public func addRandomDescendants(generator: EntropyGenerator, maxDepth: Int? = nil) {
        preconditionFailure("This method must be overridden in a subclass.")
    }
    
}
