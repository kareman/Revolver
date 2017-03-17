
/// A simple genetic algorithm running in the sequential (non-distributed) environment.
public final class GeneticAlgorithm<Chromosome: ChromosomeType> {
    
    /// Hook is a lambda function which is executed synchronously at important points through the run of the algorithm.
    public typealias Hook = (GeneticAlgorithm<Chromosome>) -> ()
    
    /// Hook with individual is just like a regular hook, but contains an individual index.
    public typealias HookWithIndividual = (GeneticAlgorithm<Chromosome>, Int) -> ()
    
    /// The provider of randomness.
    public let entropyGenerator: EntropyGenerator
    
    /// The population of individuals.
    public let population: MatingPool<Chromosome>
    
    /// The minimum number of individuals in the population.
    public let populationSize: Int
    
    /// Decision tree which is executed at the beginning of every generation.
    public let treeExecutedEveryGeneration: DecisionTreeNode<Chromosome>?
    
    /// Decision tree which is executed repeatedly until the generation is big enough.
    public let treeExecutedInLoop: DecisionTreeNode<Chromosome>
    
    /// Evaluator is responsible for calculating fitness values of individuals in the population.
    public let evaluator: Evaluator<Chromosome>
    
    /// Termination condition periodically determines if it's time to end the run.
    public let termination: TerminationCondition<Chromosome>
    
    /// Hook executed when a run starts.
    public var hookRunStarted: Hook?
    
    /// Hook executed when a run finishes.
    public var hookRunFinished: Hook?
    
    /// Hook executed when a new generation is built.
    public var hookGenerationAdvanced: Hook?
    
    /// Hook executed when the evaluation of individuals starts.
    public var hookEvaluationStarted: Hook?
    
    /// Hook executed when a single individual is evaluated.
    public var hookIndividualEvaluated: HookWithIndividual?
    
    /// Hook executed when the evaluation of individuals ends.
    public var hookEvaluationFinished: Hook?
    
    /**
     Create new instance of a genetic algorithm.
     
     - parameter generator:              The provider of randomness.
     - parameter populationSize:         The minimum number of individuals in the population.
     - parameter executeEveryGeneration: Decision tree which is executed at the beginning of every generation.
     - parameter executeInLoop:          Decision tree which is executed repeatedly until the generation is big enough.
     - parameter evaluator:              Evaluator is responsible for calculating fitness values of individuals in the population.
     - parameter termination:            Termination condition periodically determines if it's time to end the run.
     
     - returns: The new created instance.
     */
    public required init(generator: EntropyGenerator, populationSize: Int, executeEveryGeneration: DecisionTreeNode<Chromosome>?, executeInLoop: DecisionTreeNode<Chromosome>, evaluator: Evaluator<Chromosome>, termination: TerminationCondition<Chromosome>) {
        // Copy some values
        self.populationSize = populationSize
        self.entropyGenerator = generator
        self.treeExecutedEveryGeneration = executeEveryGeneration
        self.treeExecutedInLoop = executeInLoop
        self.evaluator = evaluator
        self.termination = termination
        
        // Initialize some fields.
        self.population = MatingPool<Chromosome>()
        
        // If the debug mode is turned on, occupy hooks with default implementations.
        #if DEBUG
            hookRunStarted = { _ in
                debugPrint("GeneticAlgorithm[DEBUG]: Run started.")
            }
            hookRunFinished = { _ in
                debugPrint("GeneticAlgorithm[DEBUG]: Run finished.")
            }
            hookGenerationAdvanced = { (alg: GeneticAlgorithm<Chromosome>) in
                debugPrint("GeneticAlgorithm[DEBUG]: Generation advanced: \(alg.population.currentGeneration)")
            }
            hookEvaluationStarted = { _ in
                debugPrint("GeneticAlgorithm[DEBUG]: Evaluation started.")
            }
            hookIndividualEvaluated = { _, index in
                debugPrint("GeneticAlgorithm[DEBUG]: Individual #\(index) evaluated.")
            }
            hookEvaluationFinished = { _ in
                debugPrint("GeneticAlgorithm[DEBUG]: Evaluation finished.")
            }
        #endif
    }
    
    /**
     Create new instance of a genetic algorithm.
     
     - parameter generator:              The provider of randomness.
     - parameter populationSize:         The minimum number of individuals in the population.
     - parameter executeEveryGeneration: Decision tree which is executed at the beginning of every generation.
     - parameter executeInLoop:          Decision tree which is executed repeatedly until the generation is big enough.
     - parameter evaluator:              Evaluator is responsible for calculating fitness values of individuals in the population.
     - parameter termination:            Termination condition periodically determines if it's time to end the run.
     
     - returns: The new created instance.
     */
    public convenience init(generator: EntropyGenerator, populationSize: Int, executeEveryGeneration: GeneticOperator<Chromosome>, executeInLoop: GeneticOperator<Chromosome>, evaluator: Evaluator<Chromosome>, termination: TerminationCondition<Chromosome>) {
        self.init(
            generator: generator,
            populationSize: populationSize,
            executeEveryGeneration: GeneticOperatorNode<Chromosome>(executeEveryGeneration),
            executeInLoop: GeneticOperatorNode<Chromosome>(executeInLoop),
            evaluator: evaluator,
            termination: termination
        )
    }
    
    /**
     Create new instance of a genetic algorithm.
     
     - parameter generator:              The provider of randomness.
     - parameter populationSize:         The minimum number of individuals in the population.
     - parameter executeEveryGeneration: Decision tree which is executed at the beginning of every generation.
     - parameter executeInLoop:          Decision tree which is executed repeatedly until the generation is big enough.
     - parameter evaluator:              Evaluator is responsible for calculating fitness values of individuals in the population.
     - parameter termination:            Termination condition periodically determines if it's time to end the run.
     
     - returns: The new created instance.
     */
    public convenience init(generator: EntropyGenerator, populationSize: Int, executeEveryGeneration: DecisionTreeNode<Chromosome>?, executeInLoop: GeneticOperator<Chromosome>, evaluator: Evaluator<Chromosome>, termination: TerminationCondition<Chromosome>) {
        self.init(
            generator: generator,
            populationSize: populationSize,
            executeEveryGeneration: executeEveryGeneration,
            executeInLoop: GeneticOperatorNode<Chromosome>(executeInLoop),
            evaluator: evaluator,
            termination: termination
        )
    }
    
    /**
     Create new instance of a genetic algorithm.
     
     - parameter generator:              The provider of randomness.
     - parameter populationSize:         The minimum number of individuals in the population.
     - parameter executeEveryGeneration: Decision tree which is executed at the beginning of every generation.
     - parameter executeInLoop:          Decision tree which is executed repeatedly until the generation is big enough.
     - parameter evaluator:              Evaluator is responsible for calculating fitness values of individuals in the population.
     - parameter termination:            Termination condition periodically determines if it's time to end the run.
     
     - returns: The new created instance.
     */
    public convenience init(generator: EntropyGenerator, populationSize: Int, executeEveryGeneration: GeneticOperator<Chromosome>, executeInLoop: DecisionTreeNode<Chromosome>, evaluator: Evaluator<Chromosome>, termination: TerminationCondition<Chromosome>) {
        self.init(
            generator: generator,
            populationSize: populationSize,
            executeEveryGeneration: GeneticOperatorNode<Chromosome>(executeEveryGeneration),
            executeInLoop: executeInLoop,
            evaluator: evaluator,
            termination: termination
        )
    }
    
    /**
     Run the genetic algorithm synchronously.
     
     - note: This method *blocks* the current thread until the run is finished.
     */
    public func run() {
        executeHook(hookRunStarted)
        
        // Prepare the first generation.
        seedRandomGeneration()
        evaluateNewIndividuals()
        
        executeHook(hookGenerationAdvanced)
        
        while !termination.shouldTerminate(population) {
            // Generate as many generations as needed.
            produceOffspring()
            evaluateNewIndividuals()
            
            executeHook(hookGenerationAdvanced)
        }
        
        executeHook(hookRunFinished)
    }
    
    /**
     Execute a hook.
     
     - parameter hook: The hook to execute.
     */
    fileprivate func executeHook(_ hook: Hook?) {
        guard let implementedHook = hook else { return }
        implementedHook(self)
    }
    
    /**
     Execute a hook with individual.
     
     - parameter hook:       The hook to execute.
     - parameter individual: The individual to pass as a parameter.
     */
    fileprivate func executeHook(_ hook: HookWithIndividual?, individual: Int) {
        guard let implementedHook = hook else { return }
        implementedHook(self, individual)
    }
    
    /**
     Randomly generate the population.
     */
    fileprivate func seedRandomGeneration() {
        if population.reproducing {
            // Cancel any reproduction which has been going on.
            population.cancelReproduction()
        }
        
        // Create a new generation of random individuals.
        population.beginReproduction()
        while population.offspringSize! < populationSize {
            let randomIndividual: Individual<Chromosome> = entropyGenerator.next()
            population.addOffspring(randomIndividual)
        }
        population.advanceGeneration()
    }
    
    /**
     Generate offspring population from the current population.
     */
    fileprivate func produceOffspring() {
        if population.reproducing {
            // Cancel any reproduction which has been going on.
            population.cancelReproduction()
        }
        
        // Initialize new population.
        population.beginReproduction()
        treeExecutedEveryGeneration?.execute(entropyGenerator, pool: population)
        
        // Execute decision tree until it is big enough.
        while population.offspringSize! < populationSize {
            treeExecutedInLoop.execute(entropyGenerator, pool: population)
        }
        
        // Swap populations.
        population.advanceGeneration()
    }
    
    /**
     Ensure that all individuals are evaluated.
     */
    fileprivate func evaluateNewIndividuals() {
        executeHook(hookEvaluationStarted)
        
        // Call the evaluator to do stuff synchronously.
        evaluator.evaluateIndividuals(population, individualEvaluated: { index in
            self.executeHook(self.hookIndividualEvaluated, individual: index)
        })
        
        executeHook(hookEvaluationFinished)
    }    
}
