
/// Base class for a tree data structure, which can be randomly generated.
///
/// This class is abstract meaning you probably **don't want to instantiate it directly** but create subclasses of it, instead.
///
/// When creating subclasses of this class, feel free to add as many properties as you wish. The only rule is that all
/// properties which are descendant nodes of the current node must be also referenced in the `descendants` array. This
/// array is used for quick enumeration and random generation and if there were any disconnects between its contents and
/// the real state of the data structure, algorithms working on it might produce undefined results.
public class TreeNode: TreeType {
    
    /// Next-level descendant nodes of this node, not necessarily of the same type.
    public final var descendants: [TreeType] {
        return treeNodeDescendants
    }
    
    /// Next-level descendant nodes of this node, guaranteed to be of the same type.
    public var treeNodeDescendants: [TreeNode] {
        return []
    }
    
    /// Unique identifier of the node within the tree.
    public let id: Int
    
    /// Longest path between this node and a leaf node. Stored for purposes of later modifications of the tree.
    public let maximumDepth: Int
    
    /**
     Initialize new random subtree with specified maximum depth.
     
     - parameter factory:      Object used to generate subtree of this node.
     - parameter maximumDepth: Longest path between this node and a leaf node.
     
     - returns: New random subtree.
     */
    public required init(factory: RandomTreeFactory, maximumDepth: Int) {
        self.id = factory.assignNewIdentifier()
        self.maximumDepth = maximumDepth
    }
    
    /**
     Initialize new node with field values.
     
     - parameter id:           Unique identifier of the node.
     - parameter maximumDepth: Maximum depth of the subtree.
     
     - returns: New subtree with set values.
     */
    public required init(id: Int, maximumDepth: Int) {
        self.id = id
        self.maximumDepth = maximumDepth
    }
    
    /**
     Clone the node, possibly mutating it in the process.
     
     - parameter factory: Subtree generator for the mutated node.
     - parameter id:      Identifier of the mutated node.
     
     - returns: Same tree with a mutated node.
     
     - warning: This method is abstract and *must* be implemented in a subclass.
     */
    public func clone(factory: RandomTreeFactory, mutateNodeId id: Int) -> Self {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
