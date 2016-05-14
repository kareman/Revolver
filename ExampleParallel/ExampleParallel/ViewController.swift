import Cocoa
import Revolver

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    let algorithmQueue = NSOperationQueue()
    
    @IBAction func runSequentialAlgorithmClicked(sender: AnyObject) {
        let evaluator = UnpredictableEvalutator()
        
        runAlgorithm(evaluator)
    }
    
    @IBAction func runParallelAlgorithmClicked(sender: AnyObject) {
        let evaluator = ParallelEvaluator() { threadNumber in
            return UnpredictableEvalutator(threadNumber: threadNumber)
        }
        
        runAlgorithm(evaluator)
    }
    
    func runAlgorithm(evaluator: Evaluator<EmptyChromosome>) {
        // Configuration of the algorithm.
        let twister = MersenneTwister(seed: 4242)
        
        let mutation = Mutation<EmptyChromosome>(RouletteSelection())
        let crossover = OnePointCrossover<EmptyChromosome>(TournamentSelection(order: 5))
        
        let elitism = Reproduction<EmptyChromosome>(BestSelection())
        
        let alg = GeneticAlgorithm<EmptyChromosome>(
            generator: twister,
            populationSize: 30,
            executeEveryGeneration: elitism,
            executeInLoop: (Choice(mutation, p: 0.5) ||| Choice(crossover, p: 0.5)),
            evaluator: evaluator,
            termination: MaxNumberOfGenerations(2)
        )
        
        // Some hooks to print nice stuff.
        alg.hookRunStarted = { _ in
            print("\n\n---\nRun started.")
        }
        
        alg.hookGenerationAdvanced = { a in
            print("Generation \(a.population.currentGeneration):\t\tbest: \(a.population.bestFitness),\t\tmean: \(a.population.averageFitness)")
            print("")
        }
        
        alg.hookRunFinished = {
            a in print("Run finished.")
            
            // Print the found solution.
            let bestIndividual = a.population.bestIndividual!
            print("\n\n---\nBEST FITNESS:\t\t\(bestIndividual.fitness!)")
        }
        
        // Just do it!
        let tic = NSDate()
        alg.run()
        let toc = NSDate()
        
        // A simple time benchmark.
        let time = toc.timeIntervalSinceDate(tic)
        print("TIME: \(time) seconds")
    }


}

