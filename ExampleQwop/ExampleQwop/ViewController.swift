import Cocoa
import WebKit
import Revolver

class ViewController: NSViewController, WebFrameLoadDelegate {    
    let simulationQueue = OperationQueue()
    let algorithmQueue = OperationQueue()
    
    let sim = Simulation()
    let qwopURL = URL(string: "http://www.foddy.net/Athletics.html?webgl=true")!

    @IBOutlet weak var webView: WebView!
    @IBOutlet weak var statusLabel: NSTextField!
    
    let twister = MersenneTwister(seed: 4242)
    
    var chromosome: QwopChromosome!
    var tries: Int = 0
    var time: TimeInterval = 0
    
    var completion: (Fitness) -> () = { _ in }
    
    var evaluator: QwopEvaluator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        evaluator = QwopEvaluator(controller: self)
    }
    
    func reloadBrowser() {
        statusLabel.stringValue = "loading website"
        
        let request = URLRequest(url: qwopURL)
        webView.mainFrame.load(request)
    }
    
    func evaluateChromosome(_ chromosome: QwopChromosome, completion: @escaping (Fitness) -> ()) {
        print("   - evaluate: \(chromosome.programString)")
        
        // Settings
        self.chromosome = chromosome
        self.tries = 1
        self.time = 30
        
        self.completion = completion
        
        OperationQueue.main.addOperation {
            self.reloadBrowser()
        }
    }
    
    func launchExternalApp() {
        statusLabel.stringValue = "running \(chromosome.programString)"
        
        simulationQueue.addOperation {
            let fitness = self.sim.testChromosome(self.chromosome, tries: self.tries, time: self.time)
            print("      - fitness: \(fitness)")
            
            DispatchQueue.main.async {
                self.statusLabel.stringValue = "fitness \(fitness)"
                self.completion(fitness)
            }
        }
    }
    
    func webView(_ sender: WebView!, didFinishLoadFor frame: WebFrame!) {
        guard frame.isEqual(webView.mainFrame) else { return }
        let delayTime = DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        statusLabel.stringValue = "waiting for the game to load"
        
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            // Give the browser some time to load the game.
            self.launchExternalApp()
        }
    }
    
    var alg: GeneticAlgorithm<QwopChromosome>!
    
    @IBAction func runAlgorithmClicked(_ sender: AnyObject) {
        // Configuration of the algorithm.
        let reproduction = Reproduction<QwopChromosome>(RandomSelection())
        let mutation = Mutation<QwopChromosome>(RouletteSelection())
        let crossover = OnePointCrossover<QwopChromosome>(TournamentSelection(order: 5))
        
        let elitism = Reproduction<QwopChromosome>(BestSelection())
        let tomorrow = Date().addingTimeInterval(18 * 60 * 60)
        
        alg = GeneticAlgorithm<QwopChromosome>(
            generator: twister,
            populationSize: 80,
            executeEveryGeneration: elitism,
            executeInLoop: (Choice(reproduction, p: 0.5) ||| Choice(mutation, p: 0.3) ||| Choice(crossover, p: 0.2)),
            evaluator: evaluator,
            termination: FitnessThreshold(0.8) || AfterDate(tomorrow)
        )
        
        // Some hooks to print nice stuff.
        alg.hookRunStarted = { _ in
            print("\n\n---\nRun started.")
        }
        
        alg.hookGenerationAdvanced = { a in
            print("Generation \(a.population.currentGeneration):\t\tbest: \(a.population.bestFitness),\t\tmean: \(a.population.averageFitness)")
        }
        
        alg.hookRunFinished = { a in
            print("Run finished.")
            
            // Print the found solution.
            let bestIndividual = a.population.bestIndividual!
            print("\n\n---\nBEST FITNESS:\t\t\(bestIndividual.fitness!)")
            print("CHROMOSOME:\t\t\(bestIndividual.chromosome.programString)")
            print("LENGTH:\t\t\t\(bestIndividual.chromosome.array.count)")
        }
        
        algorithmQueue.addOperation {
            // Just do it!
            let tic = Date()
            self.alg.run()
            let toc = Date()
            
            // A simple time benchmark.
            let time = toc.timeIntervalSince(tic)
            print("TIME:\t\t\t\t\(time) seconds")
        }
    }
    
    
}
