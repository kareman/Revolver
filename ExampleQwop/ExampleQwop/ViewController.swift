import Cocoa
import WebKit
import Revolver

class ViewController: NSViewController, WebFrameLoadDelegate {
    
    let simulationQueue = NSOperationQueue()
    
    let sim = Simulation()
    let qwopURL = NSURL(string: "http://www.foddy.net/Athletics.html?webgl=true")!

    @IBOutlet weak var webView: WebView!
    @IBOutlet weak var attemptsField: NSTextField!
    @IBOutlet weak var programField: NSTextField!
    
    @IBOutlet weak var statusLabel: NSTextField!
    
    let random = MersenneTwister(seed: 1234)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func reloadBrowser() {
        statusLabel.stringValue = "loading website"
        browserSimulations = 0
        
        let request = NSURLRequest(URL: qwopURL)
        webView.mainFrame.loadRequest(request)
    }
    
    var program: [Command] = []
    var tries: Int = 0
    var time: NSTimeInterval = 0
    
    var browserSimulations: Int? = nil
    let maxBrowserSimulations = 10
    
    func runSimulation() {
        let chromosome: Chromosome = random.next()
        
        // Settings
        program = chromosome.array
        tries = 3
        time = 30
        
        programField.stringValue = Simulation.programString(program)
        attemptsField.stringValue = "\(tries)"
        
        if browserSimulations == nil || browserSimulations! > maxBrowserSimulations {
            reloadBrowser()
        } else {
            launchExternalApp()
        }
    }
    
    func launchExternalApp() {
        statusLabel.stringValue = "running"
        if let current = browserSimulations {
            browserSimulations = current + tries
        } else {
            browserSimulations = tries
        }
        
        simulationQueue.addOperationWithBlock {
            let fitness = self.sim.testProgram(self.program, tries: self.tries, time: self.time)
            
            dispatch_async(dispatch_get_main_queue()) {
                self.statusLabel.stringValue = "fitness \(fitness)"
            }
        }
    }
    
    @IBAction func runSimulationClicked(sender: AnyObject) {
        runSimulation()
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
    
    
}
