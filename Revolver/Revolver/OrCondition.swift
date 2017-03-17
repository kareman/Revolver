
/// Combine two termination conditions together by the OR operation.
///
/// **Pro Tip:** You can use this class with nicer syntax by combining conditions with the `||` operator.
open class OrCondition<Chromosome: ChromosomeType>: TerminationCondition<Chromosome> {
    
    /// The first operand of the OR operation.
    open let firstOperand: TerminationCondition<Chromosome>
    
    /// The second operand of the OR operation.
    open let secondOperand: TerminationCondition<Chromosome>
    
    /**
     Combine two termination conditions together by the OR operation.
     
     **Pro Tip:** You can use this class with nicer syntax by combining conditions with the `||` operator.
     
     - parameter first:  The first operand of the OR operation.
     - parameter second: The second operand of the OR operation.
     
     - returns: New termination condition.
     */
    public init(_ first: TerminationCondition<Chromosome>, _ second: TerminationCondition<Chromosome>) {
        self.firstOperand = first
        self.secondOperand = second
        super.init()
    }
    
    open override func shouldTerminate(_ population: MatingPool<Chromosome>) -> Bool {
        return firstOperand.shouldTerminate(population) || secondOperand.shouldTerminate(population)
    }
    
}

public func ||<Chromosome: ChromosomeType>(lhs: TerminationCondition<Chromosome>, rhs: TerminationCondition<Chromosome>) -> TerminationCondition<Chromosome> {
    return OrCondition(lhs, rhs)
}
