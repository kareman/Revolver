public class Individual<Chromosome: Randomizable>: Randomizable {
    public var chromosome: Chromosome
    public var fitness: Float?
    
    public required init(generator: EntropyGenerator) {
        self.chromosome = Chromosome(generator: generator)
        self.fitness = nil
    }
}