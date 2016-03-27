
/// Unary node represents any unary operation (function of one argument).
public class UnaryNode<OperandType: Randomizable, ResultType: Randomizable>: ValueNode<ResultType> {
    
    /// Argument of the function.
    public var operand: ValueNode<OperandType>
    
    /**
     Initialize new random subtree with specified maximum depth.
     
     - parameter factory:      Object used to generate subtree of this node.
     - parameter maximumDepth: Longest path between this node and a leaf node.
     
     - returns: New random subtree.
     */
    public required init(factory: RandomTreeFactory, maximumDepth: Int) {
        operand = factory.createRandomValueNode(maximumDepth - 1)
        
        super.init(factory: factory, maximumDepth: maximumDepth)
        descendants.appendContentsOf([operand] as [TreeType])
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
    
}
