import Cocoa
import Revolver

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func runAlgorithmClicked(_ sender: AnyObject) {
        runAlgorithm()
    }
    
    func runAlgorithm() {
        // Configuration of the algorithm.
        let twister = MersenneTwister(seed: 4242)
        let evaluator = MaxOneEvaluator()
        
        let reproduction = Reproduction<MaxOneChromosome>(RandomSelection())
        let mutation = Mutation<MaxOneChromosome>(RouletteSelection())
        let crossover = OnePointCrossover<MaxOneChromosome>(TournamentSelection(order: 5))
        
        let elitism = Elitism<MaxOneChromosome>()
        
        let alg = GeneticAlgorithm<MaxOneChromosome>(
            generator: twister,
            populationSize: 200,
            executeEveryGeneration: elitism,
            executeInLoop: (Choice(reproduction, p: 0.5) ||| Choice(mutation, p: 0.3) ||| Choice(crossover, p: 0.2)),
            evaluator: evaluator,
            termination: MaxNumberOfGenerations(1000) || FitnessThreshold(1)
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
            print("\n\n---\nBEST FITNESS:\t\t\(bestIndividual.fitness!)")
            print("CHROMOSOME:\t\t\(bestIndividual.chromosome.bitString)")
            print("LENGTH:\t\t\t\(bestIndividual.chromosome.array.count)")
        }
        
        // Just do it!
        let tic = Date()
        alg.run()
        let toc = Date()
        
        // A simple time benchmark.
        let time = toc.timeIntervalSince(tic)
        print("TIME:\t\t\t\t\(time) seconds")
    }
}

