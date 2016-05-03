
/// Combine two termination conditions together by the AND operation.
///
/// **Pro Tip:** You can use this class with nicer syntax by combining conditions with the `&&` operator.
public class AndCondition<Chromosome: Randomizable>: TerminationCondition<Chromosome> {
    
    /// The first operand of the AND operation.
    public let firstOperand: TerminationCondition<Chromosome>
    
    /// The second operand of the AND operation.
    public let secondOperand: TerminationCondition<Chromosome>
    
    /**
     Combine two termination conditions together by the AND operation.
     
     **Pro Tip:** You can use this class with nicer syntax by combining conditions with the `&&` operator.
     
     - parameter first:  The first operand of the AND operation.
     - parameter second: The second operand of the AND operation.
     
     - returns: New termination condition.
     */
    init(_ first: TerminationCondition<Chromosome>, _ second: TerminationCondition<Chromosome>) {
        self.firstOperand = first
        self.secondOperand = second
    }
    
    public override func shouldTerminate(population: MatingPool<Chromosome>) -> Bool {
        return firstOperand.shouldTerminate(population) && secondOperand.shouldTerminate(population)
    }
    
}

public func &&<Chromosome: Randomizable>(lhs: TerminationCondition<Chromosome>, rhs: TerminationCondition<Chromosome>) -> TerminationCondition<Chromosome> {
    return AndCondition(lhs, rhs)
}
