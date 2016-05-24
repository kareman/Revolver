import Revolver

/// MAX-ONE evaluator favors strings with more ones in them.
class MaxOneEvaluator: SequentialEvaluator<MaxOneChromosome> {
    override func evaluateChromosome(chromosome: MaxOneChromosome) -> Fitness {
        let numberOfOnes = chromosome.array.reduce(0) { $0 + ($1 ? 1 : 0) }
        return Fitness(numberOfOnes) / Fitness(Configuration.maxNumberOfOnes)
    }
}
