import Cocoa
import WebKit
import Revolver

class ViewController: NSViewController, WebFrameLoadDelegate {    
    let simulationQueue = NSOperationQueue()
    let algorithmQueue = NSOperationQueue()
    
    let sim = Simulation()
    let qwopURL = NSURL(string: "http://www.foddy.net/Athletics.html?webgl=true")!

    @IBOutlet weak var webView: WebView!
    @IBOutlet weak var statusLabel: NSTextField!
    
    let twister = MersenneTwister(seed: 1234)
    
    var chromosome: QwopChromosome!
    var tries: Int = 0
    var time: NSTimeInterval = 0
    
    var completion: Fitness -> () = { _ in }
    
    var browserSimulations: Int? = nil
    let maxBrowserSimulations = 1
    
    var evaluator: QwopEvaluator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        evaluator = QwopEvaluator(controller: self)
    }
    
    func reloadBrowser() {
        statusLabel.stringValue = "loading website"
        browserSimulations = 0
        
        let request = NSURLRequest(URL: qwopURL)
        webView.mainFrame.loadRequest(request)
    }
    
    func evaluateChromosome(chromosome: QwopChromosome, completion: Fitness -> ()) {
        print("   - evaluate: \(chromosome.programString)")
        
        // Settings
        self.chromosome = chromosome
        self.tries = 3
        self.time = 30
        
        self.completion = completion
        
        if browserSimulations == nil || browserSimulations! > maxBrowserSimulations {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.reloadBrowser()
            }
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.launchExternalApp()
            }
        }
    }
    
    func launchExternalApp() {
        statusLabel.stringValue = "running \(chromosome.programString)"
        if let current = browserSimulations {
            browserSimulations = current + tries
        } else {
            browserSimulations = tries
        }
        
        simulationQueue.addOperationWithBlock {
            let fitness = self.sim.testChromosome(self.chromosome, tries: self.tries, time: self.time)
            print("      - fitness: \(fitness)")
            
            dispatch_async(dispatch_get_main_queue()) {
                self.statusLabel.stringValue = "fitness \(fitness)"
                self.completion(fitness)
            }
        }
    }
    
    func webView(sender: WebView!, didFinishLoadForFrame frame: WebFrame!) {
        guard frame.isEqual(webView.mainFrame) else { return }
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        statusLabel.stringValue = "waiting for the game to load"
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            // Give the browser some time to load the game.
            self.launchExternalApp()
        }
    }
    
    var alg: GeneticAlgorithm<QwopChromosome>!
    
    @IBAction func runAlgorithmClicked(sender: AnyObject) {
        // Configuration of the algorithm.
        let reproduction = Reproduction<QwopChromosome>(RandomSelection())
        let mutation = Mutation<QwopChromosome>(RouletteSelection())
        let crossover = OnePointCrossover<QwopChromosome>(TournamentSelection(order: 5))
        
        let elitism = Reproduction<QwopChromosome>(BestSelection())
        
        alg = GeneticAlgorithm<QwopChromosome>(
            generator: twister,
            populationSize: 200,
            executeEveryGeneration: elitism,
            executeInLoop: (Choice(reproduction, p: 0.5) ||| Choice(mutation, p: 0.3) ||| Choice(crossover, p: 0.2)),
            evaluator: evaluator,
            termination: MaxNumberOfGenerations(10) || FitnessThreshold(1)
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
        
        algorithmQueue.addOperationWithBlock {
            // Just do it!
            let tic = NSDate()
            self.alg.run()
            let toc = NSDate()
            
            // A simple time benchmark.
            let time = toc.timeIntervalSinceDate(tic)
            print("TIME:\t\t\t\t\(time) seconds")
        }
    }
    
    
}
