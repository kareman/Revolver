
/// Sequential evaluator evaluates all individuals in sequence.
///
/// This class is abstract. You **cannot** instantiate it directly.
/// When subclassing it, be sure to override the `evaluateChromosome()` method.
open class SequentialEvaluator<Chromosome: ChromosomeType>: Evaluator<Chromosome> {
    
    public override init() {
        super.init()
    }
    
    public final override func evaluateIndividuals(_ individuals: MatingPool<Chromosome>, individualEvaluated: @escaping EvaluationHandler) {
        for individualIndex in 0..<individuals.populationSize {
            // Go through the population and make sure all individuals are evaluated.
            
            guard individuals.individualAtIndex(individualIndex).fitness == nil else {
                // The individual has been already evaluated once.
                // We don't need to evaluate it twice.
                individualEvaluated(individualIndex)
                
                continue
            }
            
            // Evaluate individual synchronously.
            let chromosome = individuals.individualAtIndex(individualIndex).chromosome
            let fitness = evaluateChromosome(chromosome)
            
            // Save the evaluation for later.
            individuals.individualAtIndex(individualIndex).fitness = fitness
            individualEvaluated(individualIndex)
        }
    }
    
    /**
     Evaluate a single chromosome.
     
     - parameter chromosome: Chromosome to evaluate.
     
     - returns: Fitness function value.
     - warning: This method is abstract. You **must** override it in subclasses.
     */
    open func evaluateChromosome(_ chromosome: Chromosome) -> Fitness {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
