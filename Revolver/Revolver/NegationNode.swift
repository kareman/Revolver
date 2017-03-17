
/// Negation node encapsulates the operation of logical negation (NOT) on a Boolean value.
public final class NegationNode: UnaryNode<Bool, Bool> {
    
    /**
     Initialize new random subtree with specified maximum depth.
     
     - parameter factory:      Object used to generate subtree of this node.
     - parameter maximumDepth: Longest path between this node and a leaf node.
     
     - returns: New random subtree.
     */
    public required init(factory: RandomTreeFactory, maximumDepth: Int) {
        super.init(factory: factory, maximumDepth: maximumDepth)
    }
    
    /**
     Initialize new node with field values.
     
     - parameter id:           Unique identifier of the node.
     - parameter maximumDepth: Maximum depth of the subtree.
     - parameter operand:      Argument of the function.
     
     - returns: New node with set values.
     */
    public required init(id: Int, maximumDepth: Int, operand: ValueNode<Bool>) {
        super.init(id: id, maximumDepth: maximumDepth, operand: operand)
    }
    
    /**
     Perform unary operation on an evaluated operand.
     
     - parameter operandValue: Value of the operand.
     
     - returns: Negated value of the operand.
     */
    public override func evaluate(_ operandValue: Bool) -> Bool {
        return !operandValue
    }
    
    /**
     Instantiate new node with the same id and at the same level, but with different operand.
     
     - parameter operand: Argument of the function.
     
     - returns: New instance of the current type.
     
     - remark: This method is used to specialize a general `UnaryNode` instance into one of its subclasses.
     */
    public override func callInitializer(_ operand: ValueNode<Bool>) -> NegationNode {
        return NegationNode(id: id, maximumDepth: maximumDepth, operand: operand)
    }
    
    /// Serialize the node into LISP along with its subtree.
    public override var lispString: String {
        return "(not \(operand.lispString))"
    }
    
}
