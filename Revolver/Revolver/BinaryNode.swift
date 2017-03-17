
/// Binary node represents any binary operation (function of two arguments).
open class BinaryNode<LeftSideType: Randomizable, RightSideType: Randomizable, ResultType: Randomizable>: ValueNode<ResultType> {
    
    /// The first argument of the binary operation (can be also thought of as the left-hand side).
    open let leftSide: ValueNode<LeftSideType>
    
    /// The second argument of the binary operation (can be also though of as the right-hand side).
    open let rightSide: ValueNode<RightSideType>
    
    /// Next-level descendant nodes of this node, not necessarily of the same type.
    public final override var treeNodeDescendants: [TreeNode] {
        return [ leftSide, rightSide ]
    }
    
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
    }
    
    /**
     Initialize new node with field values.
     
     - parameter id:           Unique identifier of the node.
     - parameter maximumDepth: Maximum depth of the subtree.
     - parameter leftSide:     The first argument of the binary operation.
     - parameter rightSide:    The second argument of the binary operation.
     
     - returns: New node with set values.
     */
    public required init(id: Int, maximumDepth: Int, leftSide: ValueNode<LeftSideType>, rightSide: ValueNode<RightSideType>) {
        self.leftSide = leftSide
        self.rightSide = rightSide
        super.init(id: id, maximumDepth: maximumDepth)
    }

    /**
     Calculate the value represented by the node.
     
     - parameter interpreter: Current evaluation context.
     
     - returns: Value calculated by calling the `evaluate()` function on values produced by `leftSide` and `rightSide`.
     */
    public final override func evaluate(_ interpreter: TreeInterpreter) -> ResultType {
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
    open func evaluate(leftValue: LeftSideType, rightValue: RightSideType) -> ResultType {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
    /**
     Clone the node and propagate the clone-or-mutate call to its descendants.
     
     - parameter factory: Subtree generator for the mutated node.
     - parameter id:      Identifier of the mutated node.
     
     - returns: A clone of this node with a subtree, which is possibly mutated.
     */
    open override func propagateClone(_ factory: RandomTreeFactory, mutateNodeId id: Int) -> ValueNode<ResultType> {
        // Clone the operand.
        let leftSideClone = leftSide.clone(factory, mutateNodeId: id)
        let rightSideClone = rightSide.clone(factory, mutateNodeId: id)
        
        // Construct new binary node around it.
        return callInitializer(leftSide: leftSideClone, rightSide: rightSideClone)
    }
    
    /**
     Instantiate new node with the same id and at the same level, but with different operands.
     
     - parameter leftSide: The first argument of the function.
     - parameter rightSide: The second argument of the function.
     
     - returns: New instance of the current type.
     
     - warning: This method is abstract. You *must* override it in a subclass.
     
     - remark: This method is used to specialize a general `BinaryNode` instance into one of its subclasses.
     */
    open func callInitializer(leftSide: ValueNode<LeftSideType>, rightSide: ValueNode<RightSideType>) -> Self {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
