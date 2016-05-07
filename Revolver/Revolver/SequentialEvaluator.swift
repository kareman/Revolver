
/// Sequential evaluator evaluates all individuals in sequence.
///
/// This class is abstract. You **cannot** instantiate it directly.
/// When subclassing it, be sure to override the `evaluateChromosome()` method.
public class SequentialEvaluator<Chromosome: Randomizable>: Evaluator<Chromosome> {
    
    public override init() {
        super.init()
    }
    
    public final override func evaluateIndividuals(individuals: MatingPool<Chromosome>, individualEvaluated: EvaluationHandler) {
        for individualIndex in 0..<individuals.populationSize {
            // Go through the population and make sure all individuals are evaluated.
            
            guard individuals.individualAtIndex(individualIndex).fitness == nil else {
                // The individual has been already evaluated once.
                // We don't need to evaluate it twice.
                individualEvaluated(index: individualIndex)
                
                continue
            }
            
            // Evaluate individual synchronously.
            let chromosome = individuals.individualAtIndex(individualIndex).chromosome
            let fitness = evaluateChromosome(chromosome)
            
            // Save the evaluation for later.
            individuals.individualAtIndex(individualIndex).fitness = fitness
            individualEvaluated(index: individualIndex)
        }
    }
    
    /**
     Evaluate a single chromosome.
     
     - parameter individual: Chromosome to evaluate.
     
     - returns: Fitness function value.
     - warning: This method is abstract. You **must** override it in subclasses.
     */
    public func evaluateChromosome(individual: Chromosome) -> Fitness {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
