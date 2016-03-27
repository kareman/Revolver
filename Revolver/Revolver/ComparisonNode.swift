
/// Comparison node encapsulates the operation of comparison between two `Comparable` nodes.
public final class ComparisonNode<ResultType where ResultType: Randomizable, ResultType: Comparable>: BinaryNode<ResultType, ResultType, Bool> {
    
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
     
     - returns: True if `leftValue` is lower than `rightValue`.
     */
    public override func evaluate(leftValue leftValue: ResultType, rightValue: ResultType) -> Bool {
        return leftValue < rightValue
    }
    
}
