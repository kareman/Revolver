
internal class ActionNodeExample: ActionNode {
    internal override func perform(interpreter: TreeInterpreter) {
        // Tell the robot to perform a command.
    }
    
    internal override func propagateClone(factory: RandomTreeFactory, mutateNodeId id: Int) -> ActionNode {
        let clone = ActionNodeExample(id: self.id, maximumDepth: self.maximumDepth)
        // No descendants to propagate the clone to.
        return clone
    }
}
