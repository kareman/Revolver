
/// Unary node represents any unary operation (function of one argument).
public class UnaryNode<OperandType: Randomizable, ResultType: Randomizable>: ValueNode<ResultType> {
    
    /// Argument of the function.
    public let operand: ValueNode<OperandType>
    
    /// Next-level descendant nodes of this node, not necessarily of the same type.
    public final override var treeNodeDescendants: [TreeNode] {
        return [ operand ]
    }
    
    /**
     Initialize new random subtree with specified maximum depth.
     
     - parameter factory:      Object used to generate subtree of this node.
     - parameter maximumDepth: Longest path between this node and a leaf node.
     
     - returns: New random subtree.
     */
    public required init(factory: RandomTreeFactory, maximumDepth: Int) {
        operand = factory.createRandomValueNode(maximumDepth - 1)
        super.init(factory: factory, maximumDepth: maximumDepth)
    }
    
    /**
     Initialize new node with field values.
     
     - parameter id:           Unique identifier of the node.
     - parameter maximumDepth: Maximum depth of the subtree.
     - parameter operand:      Argument of the function.
     
     - returns: New node with set values.
     */
    public required init(id: Int, maximumDepth: Int, operand: ValueNode<OperandType>) {
        self.operand = operand
        super.init(id: id, maximumDepth: maximumDepth)
    }
    
    /**
     Calculate the value represented by the node.
     
     - parameter interpreter: Current evaluation context.
     
     - returns: Value of the `operand`, altered by the `evaluate()` function.
     */
    public final override func evaluate(interpreter: TreeInterpreter) -> ResultType {
        let operandValue = operand.evaluate(interpreter)
        return evaluate(operandValue)
    }
    
    /**
     Perform unary operation on an evaluated operand.
     
     - parameter operandValue: Value of the operand.
     
     - returns: Value represented by the node.
     
     - warning: This method is abstract. You *must* override it in a subclass.
     */
    public func evaluate(operandValue: OperandType) -> ResultType {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
    /**
     Clone the node and propagate the clone-or-mutate call to its descendants.
     
     - parameter factory: Subtree generator for the mutated node.
     - parameter id:      Identifier of the mutated node.
     
     - returns: A clone of this node with a subtree, which is possibly mutated.
     */
    public final override func propagateClone(factory: RandomTreeFactory, mutateNodeId id: Int) -> ValueNode<ResultType> {
        // Clone the operand.
        let operandClone = operand.clone(factory, mutateNodeId: id)
        
        // Construct new unary node around it.
        return callInitializer(operandClone)
    }
    
    /**
     Instantiate new node with the same id and at the same level, but with different operand.
     
     - parameter operand: Argument of the function.
     
     - returns: New instance of the current type.
     
     - warning: This method is abstract. You *must* override it in a subclass.
     
     - remark: This method is used to specialize a general `UnaryNode` instance into one of its subclasses.
     */
    public func callInitializer(operand: ValueNode<OperandType>) -> Self {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
