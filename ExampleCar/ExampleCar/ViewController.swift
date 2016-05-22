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
        // testWeights([0.0126944482, 0.374750674, 0.105009735, 0.0943619013, 0.167900443, 0.17177397, 0.141751945, -0.0498773456, 0.104761004, -0.105172843, -0.196489811, 0.331416368, -0.0654860735, -0.280395389, -0.326409012, 0.252273977, 0.295370698, -0.0407339334, 0.0454153717, -0.415717661, 0.390740573, 0.222145081, 0.246743083, 0.0135649741, 0.0271677375, 0.158179402, -0.243022621, 0.232059777, 0.169653296, -0.00498399138, 0.171733201, 0.0992848873, -0.134885997, -0.14759779, -0.114910334, 0.337057292, -0.190325856, -0.00987258554, -0.437239975, -0.300405443, 0.424700379, 0.172203004, -0.342970103, -0.172199816, -0.128920168, -0.369364738, -0.26487869, 0.213340461, 0.418412805, -0.0609714091, 0.138870299, -0.0148611367, 0.124595165, -0.138682425, -0.164555579, -0.102726907, -0.0613644421, 0.0512696207, -0.200453117, 0.255307853, 0.357442319, 0.228305638, 0.186662197, 0.168982923, -0.119724989, 0.0692142248, 0.0544279814, -0.313720703, -0.350597233, 0.425163984, 0.401983798, 0.248841286, 0.423832238, 0.407461643, 0.31782335, -0.258357525, 0.055214107, 0.423450053, -0.0808570087, 0.0876691937, 0.396573544, 0.375885963], attempts: 20, verbose: false)
        runAlgorithm()
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
        
        // Run the simulation for 1 hour (of simulated time).
        let outcome = sim.run(maxDuration: 60 * 60)
        
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
    
    func testWeights(weights: [Float], attempts: Int = 1, verbose: Bool = true) {
        let generator = MersenneTwister(seed: 4242)
        let sim = CarSimulation(verbose: verbose)
        
        // Run the network on a randomized track and generate a MATLAB script to visualize movements of the car.
        
        sim.reset()
        sim.randomizeTrack(generator)
        sim.controlProgram = NetDriver(net: FFNN(inputs: 5, hidden: 10, outputs: 2, weights: weights, activationFunction: .Sigmoid))
        
        for _ in 1...attempts {
            sim.randomizeCar(generator)
            
            // Run the simulation for 2 hours (of simulated time).
            let outcome = sim.run(maxDuration: 60 * 60)
            print("% Fitness: \(Fitness(outcome.distanceTraveledOnTrack) / Fitness(CarEvaluator.maxDistance))")
        }
    }
    
    func runAlgorithm() {
        // Configuration of the algorithm.
        let twister = MersenneTwister(seed: 1234)
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
            termination: MaxNumberOfGenerations(100) || FitnessThreshold(1)
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

