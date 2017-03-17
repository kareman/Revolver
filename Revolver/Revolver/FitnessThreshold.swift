
/**
 Type of fitness values to consider when performing comparisons.
 
 - BestFitness:    The best fitness value in the population.
 - AverageFitness: The average fitness value in the population.
 */
public enum FitnessKind {
    /// The best fitness value in the population.
    case bestFitness
    
    /// The average fitness value in the population.
    case averageFitness
}

/// Terminate the genetic algorithm after a certain fitness value is reached.
open class FitnessThreshold<Chromosome: ChromosomeType>: TerminationCondition<Chromosome> {
    
    /// The fitness value to reach.
    open let fitness: Double
    
    /// Type of fitness values, with which the constant is compared.
    open let fitnessKind: FitnessKind
    
    /**
     Terminate the genetic algorithm after a certain fitness value is reached.
     
     - parameter fitness: The fitness value to reach.
     - parameter kind:    Type of fitness values, with which the constant is compared.
     
     - returns: New termination condition.
     */
    public init(_ fitness: Double, kind: FitnessKind = .bestFitness) {
        self.fitness = fitness
        self.fitnessKind = kind
        super.init()
    }
    
    open override func shouldTerminate(_ population: MatingPool<Chromosome>) -> Bool {
        switch fitnessKind {
        case .bestFitness:
            return population.bestFitness >= fitness
            
        case .averageFitness:
            return population.averageFitness >= fitness
            
        }
    }
    
}
