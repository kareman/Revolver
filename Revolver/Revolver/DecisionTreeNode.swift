
/// A decision tree describes a chained series of actions applied in sequence on a population.
public class DecisionTreeNode<Chromosome: ChromosomeType> {
    
    private var next: DecisionTreeNode<Chromosome>?
    
    public init() {
        self.next = nil
    }
    
    public func execute(generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        guard let op = next else { return }
        op.execute(generator, pool: pool)
    }
    
    public func chain(next: DecisionTreeNode<Chromosome>) {
        self.next = next
    }
    
}
