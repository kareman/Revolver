
/* This is an example of usage of the FitnessEvaluator protocol.
 * It is made "internal" not to conflict with other objects in the library.
 */
internal class FitnessEvaluatorExample: FitnessEvaluator {
    
    // CONFIGURATION: Here you need to reference the chromosome type, on which the evaluations are based.
    internal typealias Chromosome = RangeInitializedArrayExample
    
    internal required init() { }
    
    internal func evaluate(chromosome: Chromosome) -> Double {
        /* IMPLEMENT ME: Here will probably rest the most time-expensive portion of your application.
         * This code is responsible for reading the chromosome and rating it with a [0;1] value.
         *
         * To do that, you can run a simulation or evaluate some randomized test cases.
         * Just make sure you catch all exceptions, so that your app can handle occasional errors.
         */
        
        // EXAMPLE: Let's be optimistic. Every solution is 100% good.
        return 1.0
    }
    
}