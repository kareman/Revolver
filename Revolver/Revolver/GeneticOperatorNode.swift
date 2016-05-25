
/// A genetic operator node applies a genetic operator on population upon execution.
public class GeneticOperatorNode<Chromosome: ChromosomeType>: DecisionTreeNode<Chromosome> {
    
    /// The operator to apply.
    private var currentOperator: GeneticOperator<Chromosome>
    
    /**
     Create new genetic operator node.
     
     - parameter op: Genetic operator to apply.
     
     - returns: The new instance.
     */
    public init(_ op: GeneticOperator<Chromosome>) {
        self.currentOperator = op
        super.init()
    }
    
    public override func execute(generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        currentOperator.apply(generator, pool: pool)
        super.execute(generator, pool: pool)
    }
    
}
