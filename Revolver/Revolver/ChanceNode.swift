
/// A chance node non-deterministically selects one of multiple choices.
public class ChanceNode<Chromosome: ChromosomeType>: DecisionTreeNode<Chromosome> {
    
    private var choices: [Choice<Chromosome>]
    private var sum: Double
    
    public override init() {
        sum = 0
        choices = []
    }
    
    public func split(choice: Choice<Chromosome>) {
        choices.append(choice)
        sum += choice.probability
    }
    
    private func executeChoice(generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        guard !choices.isEmpty else { return }
        
        // Choose a value at random.
        let randomValue: Double = generator.nextInRange(min: 0, max: sum)
        
        // Find the element responsible.
        var currentSum: Double = 0
        for choice in choices {
            let newSum = currentSum + choice.probability
            
            if currentSum <= randomValue && randomValue < newSum {
                // We have found the one.
                choice.execute(generator, pool: pool)
                return
            }
            
            currentSum = newSum
        }
        
        // Fallback for case when randomValue == sum.
        choices.last!.execute(generator, pool: pool)
    }
    
    public override func execute(generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        executeChoice(generator, pool: pool)
        super.execute(generator, pool: pool)
    }
    
}
