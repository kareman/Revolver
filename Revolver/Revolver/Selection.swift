
/// Method of selecting individuals from population.
public class Selection {
    
    /// Number of individuals to select.
    public let numberOfIndividuals: Int
    
    /// Provider of randomness, if required.
    public private(set) var entropyGenerator: EntropyGenerator
    
    /// Set of indices in the population.
    public typealias IndexSet = [Int]
    
    /// Value indicating whether the selection object is prepared for the current population.
    public internal(set) var prepared: Bool
    
    /**
     Constructs new selection object.
     
     - parameter numberOfIndividuals: Number of individuals to select.
     - parameter generator:           Provider of randomness, if required.
     
     - returns: New instance of the selection object.
     */
    public init(numberOfIndividuals: Int, generator: EntropyGenerator) {
        self.numberOfIndividuals = numberOfIndividuals
        self.entropyGenerator = generator
        self.prepared = false
    }
    
    /**
     This method is called when the population pool changes.
     
     It allows the selection object to prefetch some population-specific values so that they don't need to be
     recaulculated every time selection happens, ultimately accelerating the selection process.
    
     - parameter population: Population to select from.
                             It is guaranteed that at the time of calling this method, the `fitness` property
                             of all individuals in the population is not equal to `nil`.
     - warning: This method is abstract and *must* be implemented in a subclass.
     */
    public func prepareForNewPopulation(population: [FitnessType]) {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
    /**
     This method is called when the selection occurs.
     
     The subclass is responsible for enforcing that `prepareForNewPopulation()` method is called first.
     
     - returns: Set of indices corresponding with selected individuals in the population.
     - warning: This method is abstract and *must* be implemented in a subclass.
     */
    public func select() -> IndexSet {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
    /**
     This method is called when the population pool ceases to be valid.
     */
    public func currentPopulationInvalidated() {
        prepared = false
    }
    
}
