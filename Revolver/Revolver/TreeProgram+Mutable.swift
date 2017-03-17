
extension TreeProgram: Mutable {
    
    public func mutate(_ generator: EntropyGenerator) -> TreeProgram {
        // Select a random node by its index.
        let randomNodeIndex = generator.nextInRange(min: 0, max: descendantIds.count - 1)
        let randomNodeId = descendantIds[randomNodeIndex]
        
        // Clone the tree, swapping the node for a random new one.
        let mutatedRoot = root.clone(factory, mutateNodeId: randomNodeId)
        
        // Return new program.
        let mutatedTree = TreeProgram(factory: factory, root: mutatedRoot)
        return mutatedTree
    }
    
}
