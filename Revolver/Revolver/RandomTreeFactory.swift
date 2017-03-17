
/**
 *  Random tree factory creates random tree-like structures.
 */
public protocol RandomTreeFactory {
    
    /**
     Create new instance of the factory object.
     
     - parameter generator: Provider of randomness.
     
     - returns: New factory using specified entropy generation.
     */
    init(generator: EntropyGenerator)
    
    /// Growth constraint specifying the maximum number of nodes between the root and any of the leaves.
    var maximumTreeDepth: Int { get }
    
    /// Growth constraint specifying the maximum number of next-level descendants of nodes in the tree.
    var maximumTreeWidth: Int { get }
    
    /// Provider of randomness.
    var entropyGenerator: EntropyGenerator { get }
    
    /**
     Generate new random `ActionNode` instance.
     
     - parameter maximumDepth: Maximum depth of the subtree rooted in the node.
     
     - returns: New random instance of a `ActionNode` subclass.
     */
    func createRandomActionNode(_ maximumDepth: Int) -> ActionNode
    
    /**
     Generate new random `ValueNode` instance specialized to given `ValueType`.
     
     - parameter maximumDepth: Maximum depth of the subtree rooted in the node.
     
     - returns: New random instance of `ValueNode` subclass.
     */
    func createRandomValueNode<ValueType: Randomizable>(_ maximumDepth: Int) -> ValueNode<ValueType>
    
    /**
     Generates unique identifier for a new `TreeNode` instance.
     
     - returns: Identifier, unique to scope of the factory.
     */
    func assignNewIdentifier() -> Int
    
}
