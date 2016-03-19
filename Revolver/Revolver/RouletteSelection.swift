
/// Simple fitness-proportional selection method.
public class RouletteSelection: Selection {
    
    /// A function of one variable.
    public typealias FitnessMapping = Double -> Double
    
    /// Mapping to alter the fitness before it is processed.
    public let fitnessMapping: FitnessMapping
    
    /// Array of weights of individuals in the population. The bigger the weight, the bigger probability individual will be selected.
    internal var currentWeights: [Double] = []
    internal var currentWeightsSum: Double = 0
    
    /**
     Constructs new instance of roulette selection.
     
     - parameter numberOfIndividuals: Number of individuals to select.
     - parameter generator:           Provider of randomness for the roulette.
     - parameter fitnessMapping:      Mapping to apply on the individual's fitness. Defaults to identity.
     
     - returns: New instance with given parameters.
     */
    public init(numberOfIndividuals: Int, generator: EntropyGenerator, fitnessMapping: FitnessMapping = { $0 }) {
        self.fitnessMapping = fitnessMapping
        super.init(numberOfIndividuals: numberOfIndividuals, generator: generator)
    }
    
    /**
     Finds index of an interval containing a specific value on the roulette wheel.
     
     - parameter roulette: Value to on the wheel.
     
     - returns: Index of interval, where the value belongs.
     */
    internal func findIndexOnWheel(roulette: Double) -> Int {
        var incrementalWeight = Double(0)
        
        for index in 0..<currentWeights.count {
            // Cumulatively add weights and find the interval index, where the roulette struck.
            let newWeight = incrementalWeight + currentWeights[index]
            
            if roulette >= incrementalWeight && roulette < newWeight {
                // If the generated value belongs to this interval, return its index.
                return index
            }
            
            incrementalWeight = newWeight
        }
        
        // Fallback for roulette == 1.
        return currentWeights.count - 1
    }
    
    // MARK: Implementation of abstract methods.
    
    /**
     This method shall be called when the population pool changes.
     The selection object uses it to update weights on the roulette wheel proportional to the fitness values of individuals.
    
     - parameter population: Population to select from.
                             It is guaranteed that at the time of calling this method, the `fitness` property
                             of all individuals in the population is not equal to `nil`.
     */
    public override func prepareForNewPopulation(population: [FitnessType]) {
        // Use fitness as a weight for every individual.
        currentWeights = population.map { self.fitnessMapping($0.fitness!) }
        currentWeightsSum = currentWeights.reduce(0, combine: +)
        prepared = true
    }
    
    /**
     This method shall be called when the selection occurs.
     It is equivalent to a single batch of spins of the roulette wheel.
     
     - returns: Set of indices corresponding with selected individuals in the population.
     */
    public override func select() -> IndexSet {
        precondition(prepared, "The method select() was called on an unprepared Selection object. Call prepareForNewPopulation() first.")
        
        var foundIndexSet = IndexSet()
        for _ in 0..<numberOfIndividuals {
            // Spin the roulette.
            let roulette: Double = entropyGenerator.nextInRange(min: 0, max: currentWeightsSum)
            let foundIndex = findIndexOnWheel(roulette)
            
            // Add the index corresponding to the selected interval.
            foundIndexSet.append(foundIndex)
        }
        
        return foundIndexSet
    }
    
}
