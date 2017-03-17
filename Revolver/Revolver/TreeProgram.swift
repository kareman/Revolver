
/// Tree encapsulates a randomizable tree-like structure with executable program.
public final class TreeProgram<FactoryType: RandomTreeFactory>: TreeType {
    
    /// Factory used to generate the program and all programs derived from it.
    internal let factory: FactoryType
    
    /// Root node of the tree.
    public let root: ActionNode
    
    /// Next level descendant nodes of the current node.
    public var descendants: [TreeType] {
        return [ root ]
    }
    
    public let descendantIds: [Int]
    
    /**
     Initialize new random instance of the tree.
     
     - parameter generator: Provider of randomness.
     
     - returns: New random tree.
     */
    public required init(generator: EntropyGenerator) {
        self.factory = FactoryType(generator: generator)
        self.root = factory.createRandomActionNode(factory.maximumTreeDepth)
        
        var ids = [Int]()
        TreeProgram<FactoryType>.enumerateIds(&ids, currentNode: self.root)
        self.descendantIds = ids
    }
    
    /**
     Initialize new instance of the tree with specified fields.
     
     - parameter factory: Factory used to generate the program.
     - parameter root:    Root node of the tree.
     
     - returns: New tree with set values.
     */
    public required init(factory: FactoryType, root: ActionNode) {
        self.factory = factory
        self.root = root
        
        var ids = [Int]()
        TreeProgram<FactoryType>.enumerateIds(&ids, currentNode: self.root)
        self.descendantIds = ids
    }
    
    public required init(original: TreeProgram<FactoryType>) {
        self.factory = original.factory
        self.root = original.root
        self.descendantIds = original.descendantIds
    }
    
    /**
     Enumerate identifiers of all nodes in the tree and add them to array.
     
     - parameter indices:     Array to store identifiers.
     - parameter currentNode: Current node to process.
     */
    fileprivate class func enumerateIds(_ indices: inout [Int], currentNode: TreeNode) {
        indices.append(currentNode.id)
        
        for descendant in currentNode.treeNodeDescendants {
            enumerateIds(&indices, currentNode: descendant)
        }
    }
    
    /// Serialize the program into LISP along with its subtree.
    public var lispString: String {
        return root.lispString
    }
    
}
