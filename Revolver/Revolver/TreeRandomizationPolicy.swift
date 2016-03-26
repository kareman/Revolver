
/**
 *  Object used for random tree growth. It complies to the Policy and Factory pattern.
 */
public protocol TreeRandomizationPolicy {
    
    /**
     A parameterless initializer is required.
     
     - returns: New instance of the policy object.
     */
    init()
    
    /// Maximum number of nodes between the root and any of the leaves.
    var maximumDepth: Int { get }
    
    /// Maximum number of next-level descendants of a node in the tree.
    var maximumWidth: Int { get }
    
    /**
     Factory function generating new random `ActionNode` instance.
     
     - parameter generator: Provider of randomness.
     - parameter policy:    Current growth policy.
     - parameter depth:     Maximum depth of the generated subtree. If `nil`, defaults to the policy.
     
     - returns: New random instance of a `ActionNode` subclass.
     */
    func createRandomAction(generator: EntropyGenerator, policy: TreeRandomizationPolicy, depth: Int?) -> ActionNode
    
    /**
     Factory function generating new random `ValueNode` instance specialized to given `ValueType`.
     
     - parameter generator: Provider of randomness.
     - parameter policy:    Current growth policy.
     - parameter depth:     Maximum depth of the generated subtree. If `nil`, defaults to the policy.
     
     - returns: New random instance of `ValueNode` subclass.
     */
    func createRandomValue<ValueType: Randomizable>(generator: EntropyGenerator, policy: TreeRandomizationPolicy, depth: Int?) -> ValueNode<ValueType>
    
}
