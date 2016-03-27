
/// Constant node represents any hardcoded randomizable value.
public final class ConstantNode<ValueType: Randomizable>: ValueNode<ValueType> {
    
    /// Value of the constant.
    public var constant: ValueType
    
    /**
     Initialize new random subtree with specified maximum depth.
     
     - parameter factory:      Object used to generate subtree of this node.
     - parameter maximumDepth: Longest path between this node and a leaf node.
     
     - returns: New random subtree.
     */
    public required init(factory: RandomTreeFactory, maximumDepth: Int) {
        self.constant = factory.entropyGenerator.next()
        
        super.init(factory: factory, maximumDepth: maximumDepth)
    }
    
    /**
     Calculate the value represented by the node.
     
     - parameter interpreter: Current evaluation context.
     
     - returns: Value of the constant.
     */
    public override func evaluate(interpreter: TreeInterpreter) -> ValueType {
        return constant
    }
    
}
