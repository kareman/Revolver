
/**
 *  Operation queue regulates the execution of a set of operations.
 */
public protocol OperationQueue {
    
    /// A Boolean value indicating whether the queue is actively scheduling operations for execution.
    var suspended: Bool { get set }
    
    /// The number of operations currently in the queue. (read-only)
    var operationCount: Int { get }
    
    /**
     Wraps the specified block in an operation object and adds it to the receiver.
     
     - parameter block: The block to execute from the operation object. The block should take no parameters and have no return value.
     */
    func addOperationWithBlock(block: () -> Void)
    
    /**
     Cancels all queued and executing operations.
     */
    func cancelAllOperations()
    
    /**
     Blocks the current thread until all of the receiver’s queued and executing operations finish executing.
     */
    func waitUntilAllOperationsAreFinished()
    
}
