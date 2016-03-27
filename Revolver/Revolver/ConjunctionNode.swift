
/// Conjunction node encapsulates the logical AND operation carried out on two Boolean values.
public final class ConjunctionNode: BinaryNode<Bool, Bool, Bool> {
    
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
     
     - returns: `leftValue` AND `rightValue`
     */
    public override func evaluate(leftValue leftValue: Bool, rightValue: Bool) -> Bool {
        return leftValue && rightValue
    }
    
}
