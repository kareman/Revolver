
/// A simple genetic algorithm running in sequential (non-distributed) environment.
public class GeneticAlgorithm<Chromosome: ChromosomeType> {
    public typealias Hook = GeneticAlgorithm<Chromosome> -> ()
    
    public let entropyGenerator: EntropyGenerator
    public let population: MatingPool<Chromosome>
    public let populationSize: Int
    
    public let pipelineExecutedEveryGeneration: Pipeline<Chromosome>?
    public let pipelineExecutedInLoop: Pipeline<Chromosome>
    
    public let evaluator: Evaluator<Chromosome>
    public let termination: TerminationCondition<Chromosome>
    
    public var hookRunStarted: Hook?
    public var hookRunFinished: Hook?
    public var hookGenerationAdvanced: Hook?
    
    public init(generator: EntropyGenerator, populationSize: Int, executeEveryGeneration: Pipeline<Chromosome>?, executeInLoop: Pipeline<Chromosome>, evaluator: Evaluator<Chromosome>, termination: TerminationCondition<Chromosome>) {
        // Copy some values
        self.populationSize = populationSize
        self.entropyGenerator = generator
        self.pipelineExecutedEveryGeneration = executeEveryGeneration
        self.pipelineExecutedInLoop = executeInLoop
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
        #endif
    }
    
    public convenience init(generator: EntropyGenerator, populationSize: Int, executeEveryGeneration: GeneticOperator<Chromosome>, executeInLoop: GeneticOperator<Chromosome>, evaluator: Evaluator<Chromosome>, termination: TerminationCondition<Chromosome>) {
        self.init(
            generator: generator,
            populationSize: populationSize,
            executeEveryGeneration: GeneticOperatorPipeline<Chromosome>(executeEveryGeneration),
            executeInLoop: GeneticOperatorPipeline<Chromosome>(executeInLoop),
            evaluator: evaluator,
            termination: termination
        )
    }
    
    public convenience init(generator: EntropyGenerator, populationSize: Int, executeEveryGeneration: Pipeline<Chromosome>?, executeInLoop: GeneticOperator<Chromosome>, evaluator: Evaluator<Chromosome>, termination: TerminationCondition<Chromosome>) {
        self.init(
            generator: generator,
            populationSize: populationSize,
            executeEveryGeneration: executeEveryGeneration,
            executeInLoop: GeneticOperatorPipeline<Chromosome>(executeInLoop),
            evaluator: evaluator,
            termination: termination
        )
    }
    
    public convenience init(generator: EntropyGenerator, populationSize: Int, executeEveryGeneration: GeneticOperator<Chromosome>, executeInLoop: Pipeline<Chromosome>, evaluator: Evaluator<Chromosome>, termination: TerminationCondition<Chromosome>) {
        self.init(
            generator: generator,
            populationSize: populationSize,
            executeEveryGeneration: GeneticOperatorPipeline<Chromosome>(executeEveryGeneration),
            executeInLoop: executeInLoop,
            evaluator: evaluator,
            termination: termination
        )
    }
    
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
    
    private func executeHook(hook: Hook?) {
        guard let implementedHook = hook else { return }
        implementedHook(self)
    }
    
    private func seedRandomGeneration() {
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
    
    private func produceOffspring() {
        if population.reproducing {
            // Cancel any reproduction which has been going on.
            population.cancelReproduction()
        }
        
        population.beginReproduction()
        pipelineExecutedEveryGeneration?.execute(entropyGenerator, pool: population)
        
        while population.offspringSize! < populationSize {
            pipelineExecutedInLoop.execute(entropyGenerator, pool: population)
        }
        
        population.advanceGeneration()
    }
    
    private func resetIndividualEvaluationForNewGeneration() {
        // TODO: Set variables to nil.
    }
    
    private func processIndividualEvaluationAtIndex(individualIndex: Int) {
        // TODO: Determine the best, average and whatever other fitness.
    }
    
    private func evaluateNewIndividuals() {
        resetIndividualEvaluationForNewGeneration()
        
        // Call the evaluator to do stuff.
        evaluator.evaluateIndividuals(population, individualEvaluated: self.processIndividualEvaluationAtIndex)
    }
    
}
