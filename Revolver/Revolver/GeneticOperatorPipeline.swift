
/// A genetic operator pipeline applies a genetic operator on population.
public class GeneticOperatorPipeline<Chromosome: ChromosomeType>: Pipeline<Chromosome> {
    
    private var currentOperator: GeneticOperator<Chromosome>
    
    public init(_ op: GeneticOperator<Chromosome>) {
        self.currentOperator = op
        super.init()
    }
    
    public override func execute(generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        currentOperator.apply(generator, pool: pool)
        super.execute(generator, pool: pool)
    }
    
}
