
/// Evaluator determines quality of chromosomes.
///
/// This is an abstract class. You **cannot** instantate it directly.
/// When subclassing it, be sure to implement the `evaluateIndividuals()` method.
public class Evaluator<Chromosome: ChromosomeType> {
    
    public typealias EvaluationHandler = (index: Int) -> ()
    
    public init() { }
    
    /**
     Evaluate population of individuals.
     
     - parameter individuals:         Population to evaluate.
     - parameter individualEvaluated: Handler to call when an individual is evaluated.
     - warning: This method is abstract. You **must** override it in subclasses.
     */
    public func evaluateIndividuals(individuals: MatingPool<Chromosome>, individualEvaluated: EvaluationHandler) {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}