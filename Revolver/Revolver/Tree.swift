
/// Tree encapsulates a randomizable tree-like structure.
public class Tree<RootType: TreeNode, PolicyType: TreeRandomizationPolicy>: TreeType, Randomizable {
    
    /// Randomization policy object instance containing settings ensuring that the randomization process terminates.
    public let policy = PolicyType()
    
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
        self.root = RootType(generator: generator, policy: policy)
    }
    
}
