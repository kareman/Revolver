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
    
    @IBAction func runAlgorithmClicked(sender: AnyObject) {
        runAlgorithm()
    }
    
    func runAlgorithm() {
        // Configuration of the algorithm.
        let twister = MersenneTwister(seed: 4242)
        let evaluator = KnapsackEvaluator()
        
        let reproduction = Reproduction<KnapsackChromosome>(RandomSelection())
        let mutation = Mutation<KnapsackChromosome>(RouletteSelection())
        let crossover = OnePointCrossover<KnapsackChromosome>(TournamentSelection(order: 5))
        
        let elitism = Reproduction<KnapsackChromosome>(BestSelection())
        
        let alg = GeneticAlgorithm<KnapsackChromosome>(
            generator: twister,
            populationSize: 200,
            executeEveryGeneration: elitism,
            executeInLoop: (Choice(reproduction, p: 0.8) ||| Choice(mutation, p: 0.1) ||| Choice(crossover, p: 0.1)),
            evaluator: evaluator,
            termination: MaxNumberOfGenerations(100)
        )
        
        // Some hooks to print nice stuff.
        alg.hookRunStarted = { _ in
            print("\n\n---\nRun started.")
        }
        
        alg.hookGenerationAdvanced = { a in
            print("Generation \(a.population.currentGeneration):\t\tbest: \(a.population.bestFitness),\t\tmean: \(a.population.averageFitness)")
        }
        
        alg.hookRunFinished = {
            a in print("Run finished.")
            
            // Print the found solution.
            let bestIndividual = a.population.bestIndividual!
            print("\n\n---\nBEST FITNESS:\t\t\(bestIndividual.fitness!)\t\tCHROMOSOME: \(bestIndividual.chromosome.array)")
            
            // Print the optimal solution.
            let optimalIndividual = ProblemInstance.optimalSolution
            let optimalFitness = evaluator.evaluateChromosome(optimalIndividual)
            print("OPTIMAL FITNESS:\t\(optimalFitness)\t\tCHROMOSOME: \(optimalIndividual.array)")
            
            if ProblemInstance.optimalSolution.array == bestIndividual.chromosome.array {
                print("\nYAY, SOLUTIONS MATCH!")
            } else {
                print("\nSOLUTIONS DO NOT MATCH!")
            }
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

