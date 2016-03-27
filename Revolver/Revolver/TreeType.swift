
/**
 *  Tree type instances reference other tree types as their descendants producing a tree-like data structure.
 */
public protocol TreeType {
    
    /// Next level descendant nodes of the current node in the tree.
    var descendants: [TreeType] { get }
    
}
