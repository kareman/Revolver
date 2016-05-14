
import Foundation

/// Parallel evaluator evaluates all individuals concurrently in parallel.
///
/// - note: Unlike `SequentialEvaluator<Chromosome>`, this class is *not* abstract.
///         Be advised that you can use it without subclassing.
public class ParallelEvaluator<Chromosome: ChromosomeType>: Evaluator<Chromosome> {
    
    public let threads: [SequentialEvaluator<Chromosome>]
    public let queues: [NSOperationQueue]
    
    public required init(threads: [SequentialEvaluator<Chromosome>]) {
        precondition(!threads.isEmpty, "There has to be at least one evaluator in \"threads\".")
        self.threads = threads
        
        var createdQueues = [NSOperationQueue]()
        createdQueues.reserveCapacity(threads.count)
        
        for _ in 0..<threads.count {
            let newQueue = NSOperationQueue()
            newQueue.maxConcurrentOperationCount = 1
            createdQueues.append(newQueue)
        }
        
        self.queues = createdQueues
        super.init()
    }
    
    public convenience init(numberOfThreads: Int? = nil, createThread: Int -> SequentialEvaluator<Chromosome>) {
        let effectiveNumberOfThreads = numberOfThreads ?? ParallelEvaluator<Chromosome>.recommendedNumberOfThreads
        var threads = [SequentialEvaluator<Chromosome>]()
        
        threads.reserveCapacity(effectiveNumberOfThreads)
        for threadNumber in 0..<effectiveNumberOfThreads {
            let newThread = createThread(threadNumber)
            threads.append(newThread)
        }
        
        self.init(threads: threads)
    }
    
    public static var recommendedNumberOfThreads: Int {
        return NSProcessInfo.processInfo().activeProcessorCount
    }
    
    public final override func evaluateIndividuals(individuals: MatingPool<Chromosome>, individualEvaluated: EvaluationHandler) {
        var nextIndividualToEvaluate = 0
        let lock = NSLock()
        
        // Pause and clear all queues.
        for queue in queues {
            queue.cancelAllOperations()
            queue.waitUntilAllOperationsAreFinished()
            queue.suspended = true
        }
        
        // Add consumer operation to every queue.
        for index in 0..<queues.count {
            queues[index].addOperationWithBlock {
                while true {
                    // Find the next individual to evaluate.
                    lock.lock()
                    let individualIndex = nextIndividualToEvaluate
                    nextIndividualToEvaluate += 1
                    lock.unlock()
                    
                    guard individualIndex < individuals.populationSize else {
                        // We're done, terminate.
                        break
                    }
                    
                    guard individuals.individualAtIndex(individualIndex).fitness == nil else {
                        // The individual has been already evaluated once.
                        // We don't need to evaluate it twice.
                        individualEvaluated(index: individualIndex)
                        continue
                    }
                    
                    // Evaluate the individual synchronously.
                    let chromosome = individuals.individualAtIndex(individualIndex).chromosome
                    let fitness = self.threads[index].evaluateChromosome(chromosome)
                    
                    // Save the evaluation for later.
                    individuals.individualAtIndex(individualIndex).fitness = fitness
                    individualEvaluated(index: individualIndex)
                }
            }
        }
        
        // Set all queues loose.
        for queue in queues {
            queue.suspended = false
        }
        
        // Block the current thread until all queues are done.
        for queue in queues {
            queue.waitUntilAllOperationsAreFinished()
        }
    }
    
}
