
/// Multiplication node encapsulates the operation of multiplication of two numeric values.
public final class MultiplicationNode<ChildType where ChildType: Randomizable, ChildType: NumericType>: BinaryNode<ChildType, ChildType, ChildType> {
    
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
     Perform binary operation with evaluated arguments.
     
     - parameter leftValue:  Value of the first argument.
     - parameter rightValue: Value of the second argument.
     
     - returns: Product of two values.
     */
    public override func evaluate(leftValue leftValue: ChildType, rightValue: ChildType) -> ChildType {
        return leftValue * rightValue
    }
    
}
