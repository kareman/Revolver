
/// A chance node non-deterministically selects one of multiple choices.
open class ChanceNode<Chromosome: ChromosomeType>: DecisionTreeNode<Chromosome> {
    
    /// Choices to select from.
    fileprivate var choices: [Choice<Chromosome>]
    
    /// The sum of choice probabilities.
    fileprivate var sum: Double
    
    public override init() {
        sum = 0
        choices = []
    }
    
    /**
     Add new choice to the node.
     
     - parameter choice: Choice to add.
     */
    open func split(_ choice: Choice<Chromosome>) {
        choices.append(choice)
        sum += choice.probability
    }
    
    /**
     Execute tree represented by a choice.
     
     - parameter generator: Provider of randomness.
     - parameter pool:      The population to work on.
     */
    fileprivate func executeChoice(_ generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
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
    
    open override func execute(_ generator: EntropyGenerator, pool: MatingPool<Chromosome>) {
        executeChoice(generator, pool: pool)
        super.execute(generator, pool: pool)
    }
    
}
