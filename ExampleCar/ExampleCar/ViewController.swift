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
        testSimulation()
        // runAlgorithm()
    }
    
    func testSimulation() {
        let generator = MersenneTwister(seed: 4242)
        let sim = CarSimulation()
        
        // Place the car in the middle and orient it randomly.
        // Given enough time, it should cross the track.
        
        sim.reset()
        sim.randomizeTrack(generator)
        sim.randomizeCar(generator)
        
        // The debug driver will print detector read-outs to the console.
        sim.controlProgram = DebugDriver()
        
        // Run the simulation for 30 minutes (of simulated time).
        let outcome = sim.run(maxDuration: 30 * 60)
        
        // The outcome object contains information about simulation results.
        print("\n\n\nFinished: \(outcome)")
    }
    
    func testFFNN() {
        // Generate a random neural net.
        let generator = MersenneTwister(seed: 4242)
        let chromosome: CarChromosome = generator.next()
        let net = chromosome.toFFNN()
        
        print("Chromosome length: \(chromosome.array.count)")
        print("Chromosome: \(chromosome)")
        
        // Run test signals.
        let output1 = try! net.update(inputs: [0, 0, 0, 0, 0])
        let output2 = try! net.update(inputs: [0, 0, 1, 0, 0])
        let output3 = try! net.update(inputs: [0, 1, 1, 0, 1])
        let output4 = try! net.update(inputs: [1, 1, 1, 1, 1])
        
        // Print them out.
        print("Test output #1: \(output1)")
        print("Test output #2: \(output2)")
        print("Test output #3: \(output3)")
        print("Test output #4: \(output4)")
    }
    
    func testEvaluator() {
        // Generate a random neural net.
        let generator = MersenneTwister(seed: 4242)
        let chromosome: CarChromosome = generator.next()
        
        print("Chromosome length: \(chromosome.array.count)")
        print("Chromosome: \(chromosome)")
        
        // Evaluate it.
        let evaluator = CarEvaluator()
        let result = evaluator.evaluateChromosome(chromosome)
        
        print("Fitness: \(result)")
    }
    
    func testWeights(weights: [Float], attempts: Int = 1) {
        let generator = MersenneTwister(seed: 4242)
        let sim = CarSimulation(verbose: true)
        
        // Run the network on a randomized track and generate a MATLAB script to visualize movements of the car.
        
        sim.reset()
        sim.randomizeTrack(generator)
        sim.controlProgram = NetDriver(net: FFNN(inputs: 5, hidden: 10, outputs: 2, weights: weights, activationFunction: .Sigmoid))
        
        for _ in 1...attempts {
            sim.randomizeCar(generator)
            
            // Run the simulation for 2 hours (of simulated time).
            sim.run(maxDuration: 2 * 60 * 60)
        }
    }
    
    func runAlgorithm() {
        // Configuration of the algorithm.
        let twister = MersenneTwister(seed: 4242)
        let evaluator = ParallelEvaluator() { _ in CarEvaluator() }
        
        let reproduction = Reproduction<CarChromosome>(RandomSelection())
        let mutation = Mutation<CarChromosome>(RouletteSelection())
        let crossover = OnePointCrossover<CarChromosome>(TournamentSelection(order: 5))
        
        let elitism = Reproduction<CarChromosome>(BestSelection())
        
        let alg = GeneticAlgorithm<CarChromosome>(
            generator: twister,
            populationSize: 200,
            executeEveryGeneration: elitism,
            executeInLoop: (Choice(reproduction, p: 0.8) ||| Choice(mutation, p: 0.1) ||| Choice(crossover, p: 0.1)),
            evaluator: evaluator,
            termination: MaxNumberOfGenerations(1000)
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

