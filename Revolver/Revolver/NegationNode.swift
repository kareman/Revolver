
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
     Perform unary operation on an evaluated operand.
     
     - parameter operandValue: Value of the operand.
     
     - returns: Negated value of the operand.
     */
    public override func evaluate(operandValue: Bool) -> Bool {
        return !operandValue
    }
    
}
