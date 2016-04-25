
/// Sequence node represents a set of actions which are to be executed in specific order.
public final class SequenceNode: ActionNode {
    
    /// The ordered sequence of actions.
    public let actionSequence: [ActionNode]
    
    /// Next-level descendant nodes of this node, not necessarily of the same type.
    public override var treeNodeDescendants: [TreeNode] {
        return actionSequence
    }
    
    /**
     Initialize new random subtree with specified maximum depth.
     
     - parameter factory:      Object used to generate subtree of this node.
     - parameter maximumDepth: Longest path between this node and a leaf node.
     
     - returns: New random subtree.
     */
    public required init(factory: RandomTreeFactory, maximumDepth: Int) {
        let numberOfActions: Int
        if maximumDepth > 0 {
            // Determine the number of actions non-deterministically.
            numberOfActions = factory.entropyGenerator.nextInRange(min: 0, max: factory.maximumTreeWidth)
        } else {
            // We have exceeded the maximum depth, don't add any other actions.
            numberOfActions = 0
        }
        
        // Reserve memory to minimize overhead.
        var newActionSequence = [ActionNode]()
        newActionSequence.reserveCapacity(numberOfActions)
        
        for _ in 0..<numberOfActions {
            // Generate some random descendants.
            let action = factory.createRandomActionNode(maximumDepth - 1)
            
            // Add them to the stack.
            newActionSequence.append(action)
        }
        
        self.actionSequence = newActionSequence
        super.init(factory: factory, maximumDepth: maximumDepth)
    }
    
    /**
     Initialize new node with field values.
     
     - parameter id:           Unique identifier of the node.
     - parameter maximumDepth: Maximum depth of the subtree.
     - parameter actionSequence: Ordered sequence of actions.
     
     - returns: New node with set values.
     */
    public init(id: Int, maximumDepth: Int, actionSequence: [ActionNode]) {        
        self.actionSequence = actionSequence
        super.init(id: id, maximumDepth: maximumDepth)
    }
    
    /**
     Initialize new node with field values.
     
     - parameter id:           Unique identifier of the node.
     - parameter maximumDepth: Maximum depth of the subtree.
     
     - returns: New subtree with set values.
     
     - warning: Do NOT use this method. It will not work!
     */
    public required init(id: Int, maximumDepth: Int) {
        // FIXME: This is an ugly solution. Why does not ConstantNode need it and this class does?
        fatalError("init(id:maximumDepth:) has not been implemented")
    }
    
    /**
     Perform the sequence of actions in evaluation context.
     
     - parameter interpreter: Current evaluation context.
     */
    public override func perform(interpreter: TreeInterpreter) {
        guard interpreter.running else {
            // If the program has stopped, terminate as soon as possible.
            return
        }
        
        for action in actionSequence {
            guard interpreter.running else {
                // If the program has stopped, terminate as soon as possible.
                return
            }
            
            // Perform individual actions in the sequence.
            action.perform(interpreter)
        }
    }
    
    /**
     Clone the node and propagate the clone-or-mutate call to its descendants.
     
     - parameter factory: Subtree generator for the mutated node.
     - parameter id:      Identifier of the mutated node.
     
     - returns: A clone of this node with a subtree, which is possibly mutated.
     */
    public override func propagateClone(factory: RandomTreeFactory, mutateNodeId id: Int) -> ActionNode {
        var newSequence = [ActionNode]()
        newSequence.reserveCapacity(actionSequence.count)
        
        for action in actionSequence {
            let actionClone = action.clone(factory, mutateNodeId: id)
            newSequence.append(actionClone)
        }
        
        return SequenceNode(id: id, maximumDepth: maximumDepth, actionSequence: newSequence)
    }
    
}
