
/// Represents single individual in a population.
public class Individual<Chromosome: Randomizable>: Randomizable, FitnessType {
    
    /// Genetic information of the individual.
    public let chromosome: Chromosome
    
    /// Fitness evaluation of the individual.
    public var fitness: Double?
    
    /**
     Constructs new random individual.
     
     - parameter generator: Provider of randomness.
     
     - returns: New individual with random chromosome.
     */
    public required init(generator: EntropyGenerator) {
        self.chromosome = Chromosome(generator: generator)
        self.fitness = nil
    }
    
    /**
     Constructs new individual with a specific chromosome.
     
     - parameter chromosome: Genetic information to initialize.
     
     - returns: New individual with given chromosome.
     */
    public init(chromosome: Chromosome) {
        self.chromosome = chromosome
        self.fitness = nil
    }
    
    /**
     Constructs a copy of other individual.
     
     - parameter original: The individual to copy.
     
     - returns: Identical copy of the original individual.
     */
    public init(original: Individual<Chromosome>) {
        self.chromosome = original.chromosome
        self.fitness = original.fitness
    }
    
}
