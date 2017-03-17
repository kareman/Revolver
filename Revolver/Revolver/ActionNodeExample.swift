
internal class ActionNodeExample: ActionNode {
    internal override func perform(_ interpreter: TreeInterpreter) {
        // Tell the robot to perform a command.
    }
    
    internal override func propagateClone(_ factory: RandomTreeFactory, mutateNodeId id: Int) -> ActionNode {
        let clone = ActionNodeExample(id: self.id, maximumDepth: self.maximumDepth)
        // No descendants to propagate the clone to.
        return clone
    }
    
    override var lispString: String {
        return "action-example"
    }
}
