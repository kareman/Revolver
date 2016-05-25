
/// Conditional node represents an action depending on a predicate. During interpretation, the predicate is evaluated and
/// the action to be performed is selected.
public final class ConditionalNode: ActionNode {
    
    /// Logical condition which determines which actions are performed.
    public let predicate: ValueNode<Bool>
    
    /// Action to be performed in case `predicate` is true.
    public let trueAction: ActionNode
    
    /// Action to be performed in case `predicate` is false.
    public let falseAction: ActionNode
    
    /// Next-level descendant nodes of this node, not necessarily of the same type.
    public override var treeNodeDescendants: [TreeNode] {
        return [ predicate, trueAction, falseAction ]
    }
    
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
    }
    
    /**
     Initialize new node with field values.
     
     - parameter id:           Unique identifier of the node.
     - parameter maximumDepth: Maximum depth of the subtree.
     - parameter predicate:    Logical condition which determines which actions are performed.
     - parameter trueAction:   Action to be performed in case `predicate` is true.
     - parameter falseAction:  Action to be performed in case `predicate` is false.
     
     - returns: New node with set values.
     */
    public init(id: Int, maximumDepth: Int, predicate: ValueNode<Bool>, trueAction: ActionNode, falseAction: ActionNode) {
        self.predicate = predicate
        self.trueAction = trueAction
        self.falseAction = falseAction
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
    
    /**
     Clone the node and propagate the clone-or-mutate call to its descendants.
     
     - parameter factory: Subtree generator for the mutated node.
     - parameter id:      Identifier of the mutated node.
     
     - returns: A clone of this node with a subtree, which is possibly mutated.
     */
    public override func propagateClone(factory: RandomTreeFactory, mutateNodeId id: Int) -> ActionNode {
        let predicateClone = predicate.clone(factory, mutateNodeId: id)
        let trueActionClone = trueAction.clone(factory, mutateNodeId: id)
        let falseActionClone = falseAction.clone(factory, mutateNodeId: id)
        
        return ConditionalNode(id: id, maximumDepth: maximumDepth, predicate: predicateClone, trueAction: trueActionClone, falseAction: falseActionClone)
    }
    
    /// Serialize the node into LISP along with its subtree.
    public override var lispString: String {
        return "(if \(predicate.lispString) \(trueAction.lispString) \(falseAction.lispString))"
    }
    
}
