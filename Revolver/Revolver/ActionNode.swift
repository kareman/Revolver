
/// Action node represents a course of action.
public class ActionNode: TreeNode {
    
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
     
     - returns: New subtree with set values.
     */
    public required init(id: Int, maximumDepth: Int) {
        super.init(id: id, maximumDepth: maximumDepth)
    }
    
    /**
     Perform the action in evaluation context.
     
     - parameter interpreter: Current evaluation context.
     
     - warning: This method is abstract. You *must* override it in a subclass.
     */
    public func perform(interpreter: TreeInterpreter) {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
    /**
     Clone the node, possibly mutating it in the process.
     
     - parameter factory: Subtree generator for the mutated node.
     - parameter id:      Identifier of the mutated node.
     
     - returns: Same tree with a mutated node.
     
     - remark: This method implements an abstract method of the superclass. You don't need to worry about it in subclasses.
     */
    public final override func clone(factory: RandomTreeFactory, mutateNodeId id: Int) -> ActionNode {
        if id == self.id {
            return factory.createRandomActionNode(self.maximumDepth)
        } else {
            return propagateClone(factory, mutateNodeId: id)
        }
    }
    
    /**
     Clone the node and propagate the clone-or-mutate call to its descendants.
     
     - parameter factory: Subtree generator for the mutated node.
     - parameter id:      Identifier of the mutated node.
     
     - returns: A clone of this node with a subtree, which is possibly mutated.
     
     - warning: This method is abstract. You *must* override it in a subclass.
     */
    public func propagateClone(factory: RandomTreeFactory, mutateNodeId id: Int) -> ActionNode {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
