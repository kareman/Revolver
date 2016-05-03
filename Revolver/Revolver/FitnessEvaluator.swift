
/**
 *  Fitness evaluator determines the fitness of chromosomes.
 */
public protocol FitnessEvaluator {
    
    /// Type of the chromosome to process.
    associatedtype Chromosome
    
    /**
     Create new instance of the evaluator.
     
     - returns: New evaluator.
     */
    init()
    
    /**
     Evaluate a chromosome.
     
     - parameter chromosome: Chromosome to evaluate.
     
     - returns: Value in the [0;1] interval determining the fitness of the chromosome. (0 = worst, 1 = best)
     */
    @warn_unused_result
    func evaluate(chromosome: Chromosome) -> Double
    
}

