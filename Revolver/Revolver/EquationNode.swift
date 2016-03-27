
/// Equation node encapsulates the operation of comparison between two `Equatable` values.
public final class EquationNode<ChildType where ChildType: Randomizable, ChildType: Equatable>: BinaryNode<ChildType, ChildType, Bool> {
    
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
     
     - returns: True if the arguments are equal.
     */
    public override func evaluate(leftValue leftValue: ChildType, rightValue: ChildType) -> Bool {
        return leftValue == rightValue
    }
    
}
