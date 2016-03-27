
/// Value node represents a scalar or vector value of any type (number, boolean, etc.)
///
/// - warning: This class is abstract meaning you probably don't want to instatiate it directly. Instead, subclass it
///            and be sure to override the `evaluate()` method.
public class ValueNode<ValueType>: TreeNode {
    
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
     Calculate the value represented by the node.
     
     - parameter interpreter: Current evaluation context.
     
     - returns: Value represented by the node.
     
     - warning: This method is abstract. You *must* override it in a subclass.
     */
    public func evaluate(interpreter: TreeInterpreter) -> ValueType {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
