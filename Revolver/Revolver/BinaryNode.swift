
/// Binary node represents any binary operation (function of two arguments).
public class BinaryNode<LeftSideType: Randomizable, RightSideType: Randomizable, ResultType: Randomizable>: ValueNode<ResultType> {
    
    /// The first argument of the binary operation (can be also thought of as the left-hand side).
    public var leftSide: ValueNode<LeftSideType>
    
    /// The second argument of the binary operation (can be also though of as the right-hand side).
    public var rightSide: ValueNode<RightSideType>
    
    /**
     Initialize new random subtree with specified maximum depth.
     
     - parameter factory:      Object used to generate subtree of this node.
     - parameter maximumDepth: Longest path between this node and a leaf node.
     
     - returns: New random subtree.
     */
    public required init(factory: RandomTreeFactory, maximumDepth: Int) {
        leftSide = factory.createRandomValueNode(maximumDepth - 1)
        rightSide = factory.createRandomValueNode(maximumDepth - 1)
        
        super.init(factory: factory, maximumDepth: maximumDepth)
        descendants.appendContentsOf([leftSide, rightSide] as [TreeType])
    }
    
    /**
     Calculate the value represented by the node.
     
     - parameter interpreter: Current evaluation context.
     
     - returns: Value calculated by calling the `evaluate()` function on values produced by `leftSide` and `rightSide`.
     */
    public final override func evaluate(interpreter: TreeInterpreter) -> ResultType {
        let leftValue = leftSide.evaluate(interpreter)
        let rightValue = rightSide.evaluate(interpreter)
        
        return evaluate(leftValue: leftValue, rightValue: rightValue)
    }
    
    /**
     Perform binary operation with evaluated arguments.
     
     - parameter leftValue:  Value of the first argument.
     - parameter rightValue: Value of the second argument.
     
     - returns: Value represented by the node.
     
     - warning: This method is abstract. You *must* override it in a subclass.
     */
    public func evaluate(leftValue leftValue: LeftSideType, rightValue: RightSideType) -> ResultType {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
