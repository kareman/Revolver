public class GeneticOperator<Chromosome: Randomizable> {
    func apply(inout population: [Individual<Chromosome>]) {
        preconditionFailure("This method must be overridden in a subclass.")
    }
}
