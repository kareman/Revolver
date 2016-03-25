
/**
 *  Tree type references other tree types as its descendants.
 */
public protocol TreeType {
    
    /// Next level descendant nodes of the current node.
    var descendants: [TreeType] { get }
    
}
