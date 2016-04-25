
extension TreeNode: SequenceType {
    
    /**
     Enumerate subtree of this node by depth-first search.
     
     - returns: Generator of sequence of nodes in DFS order.
     */
    public func generate() -> AnyGenerator<TreeNode> {
        var generatorStack = [IndexingGenerator<Array<TreeNode>>]()
        generatorStack.append(treeNodeDescendants.generate())
        
        return AnyGenerator(body: {
            while var generator = generatorStack.last {
                let next = generator.next()
                
                if let nextNode = next {
                    // Explore descendants of the generated node.
                    generatorStack.append(nextNode.treeNodeDescendants.generate())
                    return nextNode
                } else {
                    // The current node is out of descendants. Back away one level.
                    generatorStack.popLast()
                }
            }
            
            // We have enumerated all nodes.
            return nil
        })
    }
    
    /// Number if nodes in the subtree of this node (excluding this node).
    public var totalNumberOfDescendants: Int {
        var count = 0
        
        for descendant in treeNodeDescendants {
            count += 1 + descendant.totalNumberOfDescendants
        }
        
        return count
    }
    
}
