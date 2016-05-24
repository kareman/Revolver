import Revolver

class KnapsackEvaluator: SequentialEvaluator<KnapsackChromosome> {
    let things: [Thing]
    let capacity: Double
    
    init(instance: ProblemInstance) {
        things = instance.things
        capacity = instance.capacity
        super.init()
    }
    
    lazy var maxValue: Double = {
        return self.things.reduce(0) { $0 + $1.value }
    }()
    
    override func evaluateChromosome(chromosome: KnapsackChromosome) -> Fitness {
        let totalSize = zip(things, chromosome.array).reduce(0) { $0 + (!$1.1 ? 0 : $1.0.size) }
        if totalSize > capacity {
            return 0
        }
        
        let totalValue = zip(things, chromosome.array).reduce(0) { $0 + (!$1.1 ? 0 : $1.0.value) }
        return totalValue / maxValue
    }    
}
