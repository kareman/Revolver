
/// Invert a termination condition.
///
/// **Pro Tip:** You can use this class with nicer syntax through the `!` prefix operator.
public class NotCondition<Chromosome: Randomizable>: TerminationCondition<Chromosome> {
    
    /// The condition to invert.
    public let operand: TerminationCondition<Chromosome>
    
    /**
     Invert a termination condition.
     
     **Pro Tip:** You can use this class with nicer syntax through the `!` prefix operator.
     
     - parameter operand: The condition to invert.
     
     - returns: New termination condition.
     */
    public init(_ operand: TerminationCondition<Chromosome>) {
        self.operand = operand
    }
    
    public override func shouldTerminate(population: MatingPool<Chromosome>) -> Bool {
        return !operand.shouldTerminate(population)
    }
    
}

public prefix func !<Chromosome: Randomizable>(lhs: TerminationCondition<Chromosome>) -> TerminationCondition<Chromosome> {
    return NotCondition(lhs)
}
