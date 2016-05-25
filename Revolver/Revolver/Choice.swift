
/// A choice is a non-deterministically selected decision of a chance node.
public class Choice<Chromosome: ChromosomeType>: GeneticOperatorNode<Chromosome> {
    
    /// Statistical probability of the choice.
    public let probability: Double
    
    /**
     Instantiate new choice.
     
     - parameter op:          Operator to apply.
     - parameter probability: Statistical probability of the choice.
     
     - returns: The new instance.
     */
    public init(_ op: GeneticOperator<Chromosome>, p probability: Double) {
        self.probability = probability
        super.init(op)
    }
    
}
