import Revolver

class MaxOneEvaluator: SequentialEvaluator<MaxOneChromosome> {
    override func evaluateChromosome(individual: MaxOneChromosome) -> Fitness {
        let numberOfOnes = individual.array.reduce(0) { $0 + ($1 ? 1 : 0) }
        return Fitness(numberOfOnes) / Fitness(Configuration.maxNumberOfOnes)
    }
}
