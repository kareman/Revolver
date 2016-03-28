
/// Tree interpreter reads and acts out control programs stored as trees.
///
/// Feel free to subclass or extend this class based on the requirements of your simulation. Members of this class
/// (or any of its subclasses) can be accessed through `ValueNode`'s `evaluate()` method or `ActionNode`'s `perform()`
/// method.
public class TreeInterpreter {
    
    /// A boolean value indicating whether the interpreter is currently running a program.
    public private(set) var running: Bool = false
    
    /**
     Main entry point to perform a program stored as a tree
     
     - parameter program: The program to perform.
     
     - remark: This method is synchronous. It will **block the current thread** until the program terminates or until `kill()`
               method is called from another thread.
     
     - precondition: No other program can be running at the same time. To verify that, check that the `running` property
                     is equal to `false`.
     */
    public func run<FactoryType: RandomTreeFactory>(program: TreeProgram<FactoryType>) {
        guard !running else {
            preconditionFailure("A program is already running. Cannot start a new one before it finishes.")
        }
        
        running = true
        program.root.perform(self)
    }
    
    /**
     Stops execution of the current program asynchronously.
     
     - precondition: There must be a program running when you call this method. To verify that, check that the `running`
                     property is equal to `true`.
     */
    public func kill() {
        guard running else {
            preconditionFailure("Called kill() but no program is running.")
        }
        
        running = false
    }
    
}
