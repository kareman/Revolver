import Revolver

class KnapsackEvaluator: SequentialEvaluator<KnapsackChromosome> {
    let things: [Thing]
    let capacity: Double
    
    override init() {
        things = ProblemInstance.things
        capacity = ProblemInstance.capacity
        super.init()
    }
    
    lazy var maxValue: Double = {
        return self.things.reduce(0) { $0 + $1.value }
    }()
    
    override func evaluateChromosome(individual: KnapsackChromosome) -> Fitness {
        let totalSize = zip(things, individual.array).reduce(0) { $0 + (!$1.1 ? 0 : $1.0.size) }
        if totalSize > capacity {
            return 0
        }
        
        let totalValue = zip(things, individual.array).reduce(0) { $0 + (!$1.1 ? 0 : $1.0.value) }
        return totalValue / maxValue
    }    
}
