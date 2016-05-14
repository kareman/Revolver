import Foundation
import Revolver

class UnpredictableEvalutator: SequentialEvaluator<EmptyChromosome> {
    
    let threadNumber: Int?
    let entropyGenerator: EntropyGenerator
    
    init(threadNumber: Int? = nil) {
        self.entropyGenerator = ArcGenerator()
        self.threadNumber = threadNumber
        
        if let thread = threadNumber {
            print("Thread \(thread): Initialized.")
        } else {
            print("Initialized.")
        }
        super.init()
    }
    
    override func evaluateChromosome(individual: EmptyChromosome) -> Fitness {
        // Generate some random numbers.
        let timeToWait = NSTimeInterval(entropyGenerator.nextInRange(min: 0.0, max: 3.0))
        let ratingToReturn: Double = entropyGenerator.next()
        
        if let thread = threadNumber {
            print("Thread \(thread): Evaluating individual... (waiting \(timeToWait) s)")
        } else {
            print("Evaluating individual... (waiting \(timeToWait) s)")
        }
        
        // Wait some time.
        NSThread.sleepForTimeInterval(timeToWait)
        
        // Return random rating.
        return Fitness(ratingToReturn)
    }
}
