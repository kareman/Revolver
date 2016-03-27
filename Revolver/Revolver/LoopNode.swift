
/// Loop node represents a `while` loop. An action is performed repeatedly until a termination condition is satisfied.
public final class LoopNode: ActionNode {
    
    /// A logical predicate determining whether the loop will stop repeating.
    public var terminationCondition: ValueNode<Bool>
    
    /// Action to perform repeatedly.
    public var action: ActionNode
    
    /**
     Initialize new random subtree with specified maximum depth.
     
     - parameter factory:      Object used to generate subtree of this node.
     - parameter maximumDepth: Longest path between this node and a leaf node.
     
     - returns: New random subtree.
     */
    public required init(factory: RandomTreeFactory, maximumDepth: Int) {
        terminationCondition = factory.createRandomValueNode(maximumDepth - 1)
        action = factory.createRandomActionNode(maximumDepth - 1)
        
        super.init(factory: factory, maximumDepth: maximumDepth)
        descendants.appendContentsOf([terminationCondition, action] as [TreeType])
    }
    
    /**
     Run the loop until the termination condition is satisfied in evaluation context.
     
     - parameter interpreter: Current evaluation context.
     */
    public override func perform(interpreter: TreeInterpreter) {
        while interpreter.running && !terminationCondition.evaluate(interpreter) {
            // Perform action in the loop.
            action.perform(interpreter)
        }
    }
    
}
