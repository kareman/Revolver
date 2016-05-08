import Revolver

class QwopEvaluator: SequentialEvaluator<QwopChromosome> {
    let controller: ViewController
    let conditionVariable: NSCondition
    
    init(controller: ViewController) {
        self.controller = controller
        self.conditionVariable = NSCondition()
    }
    
    override func evaluateChromosome(individual: QwopChromosome) -> Fitness {
        var returnValue: Fitness? = nil
        controller.evaluateChromosome(individual) { fitness in
            self.conditionVariable.lock()
            returnValue = fitness
            self.conditionVariable.signal()
            self.conditionVariable.unlock()
        }
        
        conditionVariable.lock()
        while returnValue == nil {
            conditionVariable.wait()
        }
        conditionVariable.unlock()
        
        return returnValue!
    }
}
