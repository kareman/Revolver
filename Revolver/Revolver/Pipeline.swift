
/// A pipeline describes a series of actions applied in sequence on a population.
public class Pipeline<Chromosome: Randomizable> {
    
    private var next: Pipeline<Chromosome>?
    
    public init() {
        self.next = nil
    }
    
    public func execute(generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        guard let op = next else { return }
        op.execute(generator, pool: pool)
    }
    
    public func chain(next: Pipeline<Chromosome>) {
        self.next = next
    }
    
}
