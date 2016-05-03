
/// A mating pool stores a population of individuals and manages their reproduction.
///
/// For memory efficiency reasons, a pool can hold at most two generations at a time. This is useful when a new
/// generation is constructed from the previous one. To achieve that, the pool stores `population` (which represents
/// the current generation) and `offspring` (which resembles the next generation).
///
/// The pool has two states which can be tested by evaluating the `reproducing` property. If the pool is *reproducing*,
/// the `offspring` is not `nil` and can be accessed and altered by the provided methods. Conversely, when *not reproducing*,
/// `offspring` is `nil`, hence all access to it is disabled. In both states, the current generation can be accessed for
/// reading, yet it is not to be modified in any way.
///
/// The state of the pool can be controlled by calling methods `beginReproduction()`, `cancelReproduction()` and
/// `advanceGeneration()`. The first method transitions from non-reproducing to reproducing state by initializing new
/// alterable generation of individuals. The other two help transition back to non-reproducing state by either discarding
/// or accepting the offspring as a new generation respectively.
///
/// If the offspring or any of the methods mentioned above are accessed in the wrong state, a precondition failure occurs.
public class MatingPool<Chromosome: Randomizable> {
    
    /// Type of individual stored in the mating pool.
    public typealias IndividualType = Individual<Chromosome>
    
    /// Index of the current generation, incremented after each reproduction event.
    public private(set) var currentGeneration: Int = 0
    
    private var population: [IndividualType] = []
    private var offspring: [IndividualType]? = nil
    
    /// Number of individuals in the current generation.
    public var populationSize: Int {
        return population.count
    }
    
    /// Number of individuals in the next generation.
    public var offspringSize: Int? {
        return offspring?.count
    }
    
    /// Returns whether the mating pool is in reproducing state.
    public var reproducing: Bool {
        return offspring != nil
    }
    
    /**
     Initializes empty offspring generation and switches the pool into the *reproducing* state.
     
     - precondition: The pool must not already be in the *reproducing* state. You can verify this by checking
                     the `reproducing` property.
     */
    public func beginReproduction() {
        guard !reproducing else {
            preconditionFailure("This method can be called only when not in the reproducing state.")
        }
        
        offspring = []
    }
    
    /**
     Transitions into *non-reproducing* state by replacing the discarding the offspring and retaining current population.
     
     - precondition: The pool must be in the *reproducing* state. You can verify this by checking the `reproducing` property.
     */
    public func cancelReproduction() {
        guard reproducing else {
            preconditionFailure("This method can be called only in the reproducing state.")
        }
        
        offspring = nil
    }
    
    /**
     Transitions into *non-reproducing* state by replacing the current population with the offspring.
     
     - precondition: The pool must be in the *reproducing* state. You can verify this by checking the `reproducing` property.
     */
    public func advanceGeneration() {
        guard reproducing else {
            preconditionFailure("This method can be called only in the reproducing state.")
        }
        
        population = offspring!
        offspring = nil
        currentGeneration += 1
        privateSortedIndices = nil
        privateFitnessSum = nil
        privateBestFitness = nil
    }
    
    /**
     Retrieves an individual from the current generation.
     
     - parameter index: Zero-based index of the individual.
     
     - returns: Individual at the requested index.
     */
    public func individualAtIndex(index: Int) -> IndividualType {
        return population[index]
    }
    
    /**
     Retrieves an individual from the offspring generation.
     
     - parameter index: Zero-based index of the individual.
     
     - returns: Individual at the requested index.
     
     - precondition: The pool must be in the *reproducing* state. You can verify this by checking the `reproducing` property.
     */
    public func offspringAtIndex(index: Int) -> IndividualType {
        guard reproducing else {
            preconditionFailure("This method can be called only in the reproducing state.")
        }
        
        return offspring![index]
    }
    
    /**
     Erases an individual from the offspring generation.
     
     - parameter index: Zero-based index of the individual.
     
     - precondition: The pool must be in the *reproducing* state. You can verify this by checking the `reproducing` property.
     */
    public func removeOffspringAtIndex(index: Int) {
        guard reproducing else {
            preconditionFailure("This method can be called only in the reproducing state.")
        }
        
        offspring!.removeAtIndex(index)
    }
    
    /**
     Appends an individual to the offpsring generation.
     
     - parameter individual: The individual to include in the offspring generation.
     
     - precondition: The pool must be in the *reproducing* state. You can verify this by checking the `reproducing` property.
     */
    public func addOffspring(individual: IndividualType) {
        guard reproducing else {
            preconditionFailure("This method can be called only in the reproducing state.")
        }
        
        offspring!.append(individual)
    }
    
    /// Indices of individuals in the population, sorted ascending according to their fitness. *(lazy loaded)*
    public var populationIndicesSortedByFitness: IndexSet {
        if let indices = privateSortedIndices {
            return indices
        }
        
        let indices = sortIndividualsByFitness()
        privateSortedIndices = indices
        return indices
    }
    
    private var privateSortedIndices: IndexSet?
    private func sortIndividualsByFitness() -> IndexSet {
        let indices = 0..<population.count
        return indices.sort { population[$0].fitness! < population[$1].fitness! }
    }
    
    /// Sum of all fitness values of individuals in the population. *(lazy loaded)*
    public var fitnessSum: Double {
        if let sum = privateFitnessSum {
            return sum
        }
        
        let sum = calculateFitnessSum()
        privateFitnessSum = sum
        return sum
    }
    
    private var privateFitnessSum: Double?
    private func calculateFitnessSum() -> Double {
        return population.reduce(0, combine: { $0 + $1.fitness!})
    }
    
    /// Average fitness of the individuals in the population.
    public var averageFitness: Double {
        return fitnessSum / Double(populationSize)
    }
    
    /// Best fitness value in the population. *(lazy loaded)*
    public var bestFitness: Double {
        if let best = privateBestFitness {
            return best
        }
        
        let best = calculateBestFitness()
        privateBestFitness = best
        return best
    }
    
    private var privateBestFitness: Double?
    private func calculateBestFitness() -> Double {
        return population.maxElement { $0.fitness! < $1.fitness! }!.fitness!
    }
    
}
