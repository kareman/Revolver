
/// Sequence node represents a set of actions which are to be executed in specific order.
public final class SequenceNode: ActionNode {
    
    /// The ordered sequence of actions.
    public var actionSequence = [ActionNode]()
    
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
        actionSequence.reserveCapacity(numberOfActions)
        
        for _ in 0..<numberOfActions {
            // Generate some random descendants.
            let action = factory.createRandomActionNode(maximumDepth - 1)
            
            // Add them to the stack.
            actionSequence.append(action)
        }
        
        super.init(factory: factory, maximumDepth: maximumDepth)
        descendants.appendContentsOf(actionSequence as [TreeType])
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
    
}
