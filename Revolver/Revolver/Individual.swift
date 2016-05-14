
/// A single individual of a population.
public class Individual<Chromosome: ChromosomeType>: Randomizable, FitnessType, ChromosomeType, Copyable {
    
    /// Genetic information of the individual.
    public let chromosome: Chromosome
    
    /// Fitness evaluation of the individual.
    public var fitness: Fitness?
    
    /**
     Construct a new random individual.
     
     - parameter generator: Provider of randomness.
     
     - returns: New individual with random chromosome.
     */
    public required init(generator: EntropyGenerator) {
        self.chromosome = Chromosome(generator: generator)
        self.fitness = nil
    }
    
    /**
     Construct a new individual with a specific chromosome.
     
     - parameter chromosome: Genetic information to initialize.
     
     - returns: New individual with given chromosome.
     */
    public init(chromosome: Chromosome) {
        self.chromosome = chromosome
        self.fitness = nil
    }
    
    /**
     Construct a copy of other individual.
     
     - parameter original: The individual to copy.
     
     - returns: Identical copy of the original individual.
     */
    public required init(original: Individual<Chromosome>) {
        self.chromosome = Chromosome(original: original.chromosome)
        self.fitness = original.fitness
    }
    
}
