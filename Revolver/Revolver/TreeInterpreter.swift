
/// Helper object used to perform randomly generated programs stored in a tree structure, mostly for the purposes
/// of simulation with the goal of fitness evaluation.
///
/// You are welcome to subclass it and override `performAction()` and `readValue()` functions, achieving your customized
/// behavior.
public class TreeInterpreter {
    
    /// A boolean value indicating whether the interpreter is currently running the program.
    public private(set) var running: Bool = false
    
    /**
     Main entry point to evaluate a program stored in a tree-like structure.
     
     - parameter tree: Program stored in a tree.
     
     - remark: This method is synchronous. It will block the current thread until the program terminates or until `kill()`
               method is called from another thread.
     
     - precondition: No other program can be running at the same time. To verify that, check that the `running` property
                     is equal to `false`.
     */
    public final func runTree<PolicyType: TreeRandomizationPolicy>(tree: Tree<SequenceNode, PolicyType>) {
        guard !running else {
            preconditionFailure("A program is already running. Cannot start a new one before it finishes.")
        }
        
        running = true
        performActionSequence(tree.root)
    }
    
    /**
     Stops execution of the current program asynchronously.
     
     - precondition: There must be a program running when you call this method. To verify that, check that the `running`
                     property is equal to `true`.
     */
    public final func kill() {
        guard running else {
            preconditionFailure("Called kill() but no program is running.")
        }
        
        running = false
    }
    
    /**
     Performs a sequence of actions synchronously.
     
     - parameter node: A sequence of actions to perform.
     
     - warning: Do not call this method directly! It is called from within the interpreter and it would not be left this
                exposed, if Swift had proper `protected` access control level.
     */
    public final func performActionSequence(node: SequenceNode) {
        for action in node.sequence {
            guard running else {
                // If the program has stopped, terminate as soon as possible.
                return
            }
            
            // Perform individual actions in the sequence.
            performAction(action)
        }
    }
    
    /**
     Evaluates an instance of `ValueNode` synchronously.
     
     - parameter node: A node to evaluate.
     
     - returns: Value of the node.
     
     - remark: When subclassing this method, use `is` and `as?` keywords to resolve class inheritance at runtime. If you
               can evaluate any node on your own, do so, and return the value. Otherwise, be sure to include a call to
               `super.readValue()` which can read all types of `ValueNode` which are bundled in this library. Your override
               might look like this:
     
           public override func readValue<ValueType: Randomizable>(node: ValueNode<ValueType>) -> ValueType {
               if let myNode = node as? MyAwesomeValue<ValueType> {
                   let value: ValueType = /* Obtain value in customized way. */
                   return value
               }
     
               // Propagate evaluation to the superclass.
               return super.readValue(node)
           }
     
     - warning: Do not call this method directly! It is called from within the interpreter and it would not be left this
                exposed, if Swift had proper `protected` access control level.
     
     - precondition: If a pure `ValueNode` instance or any unknown subclass is passed as the `node` parameter, a precondition
                     failure will occur. This method guarantees handle all `ValueNode` subclasses provided by the library. 
                     However, you are responsible for evaluating any other subclasses of your own.
     
     */
    public func readValue<ValueType: Randomizable>(node: ValueNode<ValueType>) -> ValueType {
        if let constant = node as? ConstantNode<ValueType> {
            // Value of a constant node is a constant.
            return constant.constant
        }
        
        preconditionFailure("Unknown value node encountered: \(node)")
    }
    
    /**
     Performs action described by an instance of `ActionNode` synchronously.
     
     - parameter node: An action to perform.
     
     - remark: When subclassing this method, use `is` and `as?` keywords to resolve class inheritance at runtime. If you
               can perform any action on your own, do so, and *consume* the call. Otherwise, be sure to include a call to
               `super.performAction()` which can handle all types of `ActionNode` which are bundled in this library.
               At the beginning of your override, include check on the `running` property to minimize the latency of
               the `kill()` method. Your override might look like this:

           public override func performAction(node: ActionNode) {
               guard running else { return }
     
               if let action = node as? MyAwesomeAction { /* Perform action 1. */ }
               else if let action = node as? MyOtherAwesomeAction { /* Perform action 2. */ }
               else {
                   // Propagate action to the superclass.
                   super.performAction(node)
               }
           }

     
     - warning: Do not call this method directly! It is called from within the interpreter and it would not be left this
                exposed, if Swift had proper `protected` access control level.
     
     - precondition: If a pure `ActionNode` instance or any unknown subclass is passed as the `node` parameter, a precondition
                     failure will occur. This method guarantees handle all `ActionNode` subclasses provided by the library.
                     However, you are responsible for evaluating any other subclasses of your own.
     */
    public func performAction(node: ActionNode) {
        guard running else {
            // If the program has stopped, terminate as soon as possible.
            return
        }
        
        if let sequence = node as? SequenceNode {
            // Call specialized procedure.
            performActionSequence(sequence)
        } else if let condition = node as? ConditionalNode {
            // Evaluate the predicate.
            let predicateSatisfied = readValue(condition.predicate)
            
            // Perform the true branch or the false branch.
            if predicateSatisfied {
                performActionSequence(condition.trueActions)
            } else {
                performActionSequence(condition.falseActions)
            }
        } else if let loop = node as? LoopNode {
            while !readValue(loop.terminationCondition) {
                guard running else {
                    // If the program has stopped, terminate as soon as possible.
                    return
                }
                
                // Perform actions in the loop.
                performActionSequence(loop.actions)
            }
        } else {
            preconditionFailure("Unknown action node encountered: \(node)")
        }
    }
    
}
