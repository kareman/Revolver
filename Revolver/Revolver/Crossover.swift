public protocol Crossoverable {
    
}

public class Crossover<Chromosome: Randomizable, Crossoverable>: GeneticOperator<Chromosome> {
    override func apply(inout population: [Individual<Chromosome>]) {
        // TODO: Select 2 individuals based on fitness.
        // TODO: Perform crossover.
        // TODO: Insert two offspring into new population.
    }
}