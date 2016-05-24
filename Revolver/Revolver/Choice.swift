
/// A choice is a non-deterministically selected decision of a chance node.
public class Choice<Chromosome: ChromosomeType>: GeneticOperatorNode<Chromosome> {
    
    public let probability: Double
    
    public init(_ op: GeneticOperator<Chromosome>, p probability: Double) {
        self.probability = probability
        super.init(op)
    }
    
}
