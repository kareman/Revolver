
/// Evaluator determines quality of chromosomes.
///
/// This is an abstract class. You **cannot** instantate it directly.
/// When subclassing it, be sure to implement the `evaluateIndividuals()` method.
open class Evaluator<Chromosome: ChromosomeType> {
    
    public typealias EvaluationHandler = (_ index: Int) -> ()
    
    public init() { }
    
    /**
     Evaluate population of individuals.
     
     - parameter individuals:         Population to evaluate.
     - parameter individualEvaluated: Handler to call when an individual is evaluated.
     - warning: This method is abstract. You **must** override it in subclasses.
     - note: This method is expected to be *synchronous*. It **must not** return to its caller until all individuals are evaluated.
     */
    open func evaluateIndividuals(_ individuals: MatingPool<Chromosome>, individualEvaluated: @escaping EvaluationHandler) {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
