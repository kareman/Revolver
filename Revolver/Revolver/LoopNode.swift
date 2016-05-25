
/// Loop node represents a `while` loop. An action is performed repeatedly until a termination condition is satisfied.
public final class LoopNode: ActionNode {
    
    /// A logical predicate determining whether the loop will stop repeating.
    public let terminationCondition: ValueNode<Bool>
    
    /// Action to perform repeatedly.
    public let action: ActionNode
    
    /// Next-level descendant nodes of this node, not necessarily of the same type.
    public override var treeNodeDescendants: [TreeNode] {
        return [ terminationCondition, action ]
    }
    
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
    }
    
    /**
     Initialize new node with field values.
     
     - parameter id:           Unique identifier of the node.
     - parameter maximumDepth: Maximum depth of the subtree.
     - parameter terminationCondition: A logical predicate determining whether the loop will stop repeating.
     - parameter action:               Action to perform repeatedly.
     
     - returns: New node with set values.
     */
    public init(id: Int, maximumDepth: Int, terminationCondition: ValueNode<Bool>, action: ActionNode) {
        self.terminationCondition = terminationCondition
        self.action = action
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
        // TODO: This is an ugly solution. Why does not ConstantNode need it and this class does? Compiler applies double standards.
        fatalError("init(id:maximumDepth:) has not been implemented")
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
    
    /**
     Clone the node and propagate the clone-or-mutate call to its descendants.
     
     - parameter factory: Subtree generator for the mutated node.
     - parameter id:      Identifier of the mutated node.
     
     - returns: A clone of this node with a subtree, which is possibly mutated.
     */
    public override func propagateClone(factory: RandomTreeFactory, mutateNodeId id: Int) -> ActionNode {
        let terminationConditionClone = terminationCondition.clone(factory, mutateNodeId: id)
        let actionClone = action.clone(factory, mutateNodeId: id)
        
        return LoopNode(id: id, maximumDepth: maximumDepth, terminationCondition: terminationConditionClone, action: actionClone)
    }
    
    /// Serialize the node into LISP along with its subtree.
    public override var lispString: String {
        return "(while (not \(terminationCondition.lispString)) \(action.lispString))"
    }
    
}
