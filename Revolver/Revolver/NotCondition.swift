
/// Invert a termination condition.
///
/// **Pro Tip:** You can use this class with nicer syntax through the `!` prefix operator.
open class NotCondition<Chromosome: ChromosomeType>: TerminationCondition<Chromosome> {
    
    /// The condition to invert.
    open let operand: TerminationCondition<Chromosome>
    
    /**
     Invert a termination condition.
     
     **Pro Tip:** You can use this class with nicer syntax through the `!` prefix operator.
     
     - parameter operand: The condition to invert.
     
     - returns: New termination condition.
     */
    public init(_ operand: TerminationCondition<Chromosome>) {
        self.operand = operand
    }
    
    open override func shouldTerminate(_ population: MatingPool<Chromosome>) -> Bool {
        return !operand.shouldTerminate(population)
    }
    
}

public prefix func !<Chromosome: ChromosomeType>(lhs: TerminationCondition<Chromosome>) -> TerminationCondition<Chromosome> {
    return NotCondition(lhs)
}
