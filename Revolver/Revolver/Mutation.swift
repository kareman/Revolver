public protocol Mutable {
    func mutate(generator: EntropyGenerator)
}

public class Mutation<Chromosome: Randomizable, Mutable>: GeneticOperator<Chromosome> {
    override func apply(inout population: [Individual<Chromosome>]) {
        // TODO: Select one individual based on fitness.
        // TODO: Perform mutation.
        // TODO: Insert mutant into new population.
    }
}
