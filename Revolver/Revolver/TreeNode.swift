
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
    public var descendants: [TreeType]
    
    /**
     Initialize new random subtree with specified maximum depth.
     
     - parameter factory:      Object used to generate subtree of this node.
     - parameter maximumDepth: Longest path between this node and a leaf node.
     
     - returns: New random subtree.
     */
    public required init(factory: RandomTreeFactory, maximumDepth: Int) {
        self.descendants = []
    }
    
}
