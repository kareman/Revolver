
/// Constant node represents any hardcoded randomizable value.
public final class ConstantNode<ValueType: Randomizable>: ValueNode<ValueType> {
    
    /// Value of the constant.
    public let constant: ValueType
    
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
     Initialize new node with field values.
     
     - parameter id:           Unique identifier of the node.
     - parameter maximumDepth: Maximum depth of the subtree.
     - parameter constant:     Value of the constant.
     
     - returns: New node with set values.
     */
    public init(id: Int, maximumDepth: Int, constant: ValueType) {
        self.constant = constant
        super.init(id: id, maximumDepth: maximumDepth)
    }

    /**
     Calculate the value represented by the node.
     
     - parameter interpreter: Current evaluation context.
     
     - returns: Value of the constant.
     */
    public override func evaluate(_ interpreter: TreeInterpreter) -> ValueType {
        return constant
    }
    
    /**
     Clone the node and propagate the clone-or-mutate call to its descendants.
     
     - parameter factory: Subtree generator for the mutated node.
     - parameter id:      Identifier of the mutated node.
     
     - returns: A clone of this node with a subtree, which is possibly mutated.
     */
    public override func propagateClone(_ factory: RandomTreeFactory, mutateNodeId id: Int) -> ValueNode<ValueType> {
        // There are no descendants, duh. Just clone the darn thing.
        return ConstantNode<ValueType>(id: self.id, maximumDepth: self.maximumDepth, constant: self.constant)
    }
    
    /// Serialize the node into LISP along with its subtree.
    public override var lispString: String {
        return "\(constant)"
    }
    
}
