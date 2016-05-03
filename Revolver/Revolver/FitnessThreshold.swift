
/**
 Type of fitness values to consider when performing comparisons.
 
 - BestFitness:    The best fitness value in the population.
 - AverageFitness: The average fitness value in the population.
 */
public enum FitnessKind {
    /// The best fitness value in the population.
    case BestFitness
    
    /// The average fitness value in the population.
    case AverageFitness
}

/// Terminate the genetic algorithm after a certain fitness value is reached.
public class FitnessThreshold<Chromosome: Randomizable>: TerminationCondition<Chromosome> {
    
    /// The fitness value to reach.
    public let fitness: Double
    
    /// Type of fitness values, with which the constant is compared.
    public let fitnessKind: FitnessKind
    
    /**
     Terminate the genetic algorithm after a certain fitness value is reached.
     
     - parameter fitness: The fitness value to reach.
     - parameter kind:    Type of fitness values, with which the constant is compared.
     
     - returns: New termination condition.
     */
    init(_ fitness: Double, kind: FitnessKind = .BestFitness) {
        self.fitness = fitness
        self.fitnessKind = kind
    }
    
    public override func shouldTerminate(population: MatingPool<Chromosome>) -> Bool {
        switch fitnessKind {
        case .BestFitness:
            return population.bestFitness >= fitness
            
        case .AverageFitness:
            return population.averageFitness >= fitness
            
        }
    }
    
}
