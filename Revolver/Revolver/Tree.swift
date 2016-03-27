
/// Tree encapsulates a randomizable tree-like structure.
public class Tree<RootType: TreeNode, FactoryType: RandomTreeFactory>: TreeType, Randomizable {
    
    /// Root of the tree.
    public var root: RootType
    
    /// Next level descendant nodes of the current node.
    public var descendants: [TreeType] {
        return [ root ]
    }
    
    /**
     Initializes new random instance of the tree.
     
     - parameter generator: Provider of randomness.
     
     - returns: New random tree.
     */
    public required init(generator: EntropyGenerator) {
        let factory = FactoryType(generator: generator)
        self.root = RootType(factory: factory, maximumDepth: factory.maximumTreeDepth)
    }
    
}
