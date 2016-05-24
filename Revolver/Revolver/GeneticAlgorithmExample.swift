
/* This is an example of usage of the GeneticAlgorithm.
 * It is made "internal" not to conflict with other objects in the library.
 */
internal class GeneticAlgorithmExample {
    
    // It's useful to define types in advance. Helps sweep away repeated portions (such as generic types).
    internal typealias MyChromosome = RangeInitializedArrayExample
    internal typealias MyEvaluator = SequentialEvaluatorExample
    internal typealias MyDecisionTree = DecisionTreeNode<MyChromosome>
    internal typealias MyAlgorithm = GeneticAlgorithm<MyChromosome>
    internal typealias MyTermination = TerminationCondition<MyChromosome>
    
    internal func run() {
        /* First, determine the size of your population.
         *
         * EXAMPLE: Here we use 42 because it is an awesome number.
         */
        let populationSize = 42
        
        /* You will need an entropy generator to produce random sequences.
         *
         * EXAMPLE: Here we picked a Mersenne Twister and set its seed, so that our results can be recreated.
         */
        let gen = MersenneTwister(seed: 1234)
        
        /* Then define 2 pipelines of genetic operators:
         *     1. The first gets executed at the "beginning" of every new generation.
         *     2. The second gets executed multiple times within every generation, until it is filled with individuals.
         * 
         * EXAMPLE: Here we use elitism as #1 to clone the best 5 individuals when creating new generations.
         *          This helps us maintain the best solution so far.
         */
        let elitism = Elitism<MyChromosome>(numberOfIndividuals: 5)
        
        /* In decision trees, you can use some cool symbols to combine operators effortlessly:
         *     e.g. "op1 ---> op2 ---> op3" produces a sequence, in which operators are applied sequentially
         *     e.g. "Choice(op1, p: 0.5) ||| Choice(op2, p: 0.5)" produces a fair coin toss between two operators.
         *     e.g. "op1 ---> (Choice(op2a, p: 0.5) ||| Choice(op2b, p: 0.5)) ---> op3" is a combination of the previous two.
         *     e.g. "Choice(op1, p: 0.75) ||| Choice(op2 ---> op3, p: 0.25)" is another combination.
         *
         * PRO TIP: Any faults in the chromosome type will show up here. Expect errors when adding a "Mutation" operator
         *          for a chromosome, which does not conform to the "Mutable" protocol, etc.
         *
         * EXAMPLE: As #2, we use a 1:3 combination of reproduction and mutation with roulette selection.
         */
        let loopOperators: MyDecisionTree = Choice(Reproduction(RouletteSelection()), p: 0.25)
                                        ||| Choice(Mutation(RouletteSelection()), p: 0.75)
        
        /* Lastly, define a termination condition, which will stop the algorithm once the solution is satisfactory.
         * In a similar way to pipelines, you can join conditions together with the !, || and && operators to get more complex behavior.
         *
         * EXAMPLE: Our algorithm terminates after 20 generations are created or after fitness 0.5 is reached.
         */
        let termination: MyTermination = MaxNumberOfGenerations(20) || FitnessThreshold(0.5)
        
        /* Instantiate the algorithm with selected fields.
         * This is the most straightforward part.
         */
        let alg = MyAlgorithm(
            generator: gen,
            populationSize: populationSize,
            executeEveryGeneration: elitism,
            executeInLoop: loopOperators,
            evaluator: MyEvaluator(),
            termination: termination)
        
        /* You can set up various hooks to be called during execution of the algorithm.
         * All such properties begin with hook...
         *
         * EXAMPLE: Here we set a simple hook to report the best and average fitness.
         */
        alg.hookGenerationAdvanced = { x in
            // Use the argument to access "alg" without capturing it in the block.
            debugPrint("Generation \(x.population.currentGeneration).    AVG: \(x.population.averageFitness)    BEST: \(x.population.bestFitness)")
        }
        
        /* The algorithm is executed by calling the "run()" method.
         * This method blocks the thread until the termination condition is true, so be careful with it!
         */
        alg.run()
    }
    
}
