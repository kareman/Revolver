
/// Cyclic evaluator uses another evaluator multiple times over to produce aggregate results.
public final class CyclicEvaluator<Chromosome: ChromosomeType>: SequentialEvaluator<Chromosome> {
    
    /// The evaluator to call multiple times.
    fileprivate let innerEvaluator: SequentialEvaluator<Chromosome>
    
    /// Number of evaluations to perform.
    public let attempts: Int
    
    /// How many evaluations are considered.
    public let select: Int
    
    /// True if the worst evaluations should be considered. (otherwise the best are considered)
    public let useWorstFitness: Bool
    
    /**
     Instantiate new evaluator.
     
     - parameter evaluator:       The evaluator to call multiple times.
     - parameter attempts:        Number of evaluations to perform.
     - parameter select:          How many evaluations are considered.
     - parameter useWorstFitness: True if the worst evaluations should be considered. (otherwise the best are considered)
     
     - returns: New instance of evaluator.
     */
    public init(evaluator: SequentialEvaluator<Chromosome>, attempts: Int, select: Int, useWorstFitness: Bool = false) {
        self.innerEvaluator = evaluator
        self.attempts = attempts
        self.select = select
        self.useWorstFitness = useWorstFitness
    }
    
    public override func evaluateChromosome(_ individual: Chromosome) -> Fitness {
        // Perform multiple evaluations.
        var results = [Fitness]()
        results.reserveCapacity(attempts)
        
        for _ in 1...attempts {
            let fitness = innerEvaluator.evaluateChromosome(individual)
            results.append(fitness)
        }
        
        // Sort those evaluations from the worst to the best or the other way.
        if useWorstFitness {
            results.sort { $0 < $1 }
        } else {
            results.sort { $0 > $1 }
        }        
        
        // Select some in the beginning.
        let selected = results[0..<select]
        
        // Return the average from the selected.
        let average = selected.reduce(0, +) / Fitness(selected.count)
        return average
    }
    
}
