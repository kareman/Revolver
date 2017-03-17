
/// Equation node encapsulates the operation of comparison between two `Equatable` values.
public final class EquationNode<ChildType>: BinaryNode<ChildType, ChildType, Bool> where ChildType: Randomizable, ChildType: Equatable {
    
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
     - parameter leftSide:     The first argument of the binary operation.
     - parameter rightSide:    The second argument of the binary operation.
     
     - returns: New node with set values.
     */
    public required init(id: Int, maximumDepth: Int, leftSide: ValueNode<ChildType>, rightSide: ValueNode<ChildType>) {
        super.init(id: id, maximumDepth: maximumDepth, leftSide: leftSide, rightSide: rightSide)
    }
    
    /**
     Perform binary operation with evaluated arguments.
     
     - parameter leftValue:  Value of the first argument.
     - parameter rightValue: Value of the second argument.
     
     - returns: True if the arguments are equal.
     */
    public override func evaluate(leftValue: ChildType, rightValue: ChildType) -> Bool {
        return leftValue == rightValue
    }
    
    /**
     Instantiate new node with the same id and at the same level, but with different operands.
     
     - parameter leftSide: The first argument of the function.
     - parameter rightSide: The second argument of the function.
     
     - returns: New instance of the current type.
     
     - remark: This method is used to specialize a general `BinaryNode` instance into one of its subclasses.
     */
    public override func callInitializer(leftSide: ValueNode<ChildType>, rightSide: ValueNode<ChildType>) -> EquationNode<ChildType> {
        return EquationNode<ChildType>(id: id, maximumDepth: maximumDepth, leftSide: leftSide, rightSide: rightSide)
    }
    
    /// Serialize the node into LISP along with its subtree.
    public override var lispString: String {
        return "(eq \(leftSide.lispString) \(rightSide.lispString))"
    }
    
}
