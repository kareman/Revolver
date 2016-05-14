
/// A choice is a non-deterministically selected pipeline branch.
public class Choice<Chromosome: ChromosomeType>: GeneticOperatorPipeline<Chromosome> {
    
    public let probability: Double
    
    public init(_ op: GeneticOperator<Chromosome>, p probability: Double) {
        self.probability = probability
        super.init(op)
    }
    
}
