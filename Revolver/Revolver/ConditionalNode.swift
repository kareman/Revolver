
/// Conditional node represents an action depending on a predicate. During interpretation, the predicate is evaluated and
/// the action to be performed is selected.
public final class ConditionalNode: ActionNode {
    
    /// Logical condition which determines which actions are performed.
    public var predicate: ValueNode<Bool>
    
    /// Action to be performed in case `predicate` is true.
    public var trueAction: ActionNode
    
    /// Action to be performed in case `predicate` is false.
    public var falseAction: ActionNode
    
    /**
     Initialize new random subtree with specified maximum depth.
     
     - parameter factory:      Object used to generate subtree of this node.
     - parameter maximumDepth: Longest path between this node and a leaf node.
     
     - returns: New random subtree.
     */
    public required init(factory: RandomTreeFactory, maximumDepth: Int) {
        predicate = factory.createRandomValueNode(maximumDepth - 1)
        trueAction = factory.createRandomActionNode(maximumDepth - 1)
        falseAction = factory.createRandomActionNode(maximumDepth - 1)
        
        super.init(factory: factory, maximumDepth: maximumDepth)
        descendants.appendContentsOf([predicate, trueAction, falseAction] as [TreeType])
    }
    
    /**
     Evaluate the condition and perform one of the actions in evaluation context.
     
     - parameter interpreter: Current evaluation context.
     */
    public override func perform(interpreter: TreeInterpreter) {
        guard interpreter.running else {
            // If the program has stopped, terminate as soon as possible.
            return
        }
        
        // Evaluate the predicate.
        let predicateSatisfied = predicate.evaluate(interpreter)
        
        // Perform the true branch or the false branch.
        if predicateSatisfied {
            trueAction.perform(interpreter)
        } else {
            falseAction.perform(interpreter)
        }
    }
    
}
