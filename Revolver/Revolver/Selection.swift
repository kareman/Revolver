
/// A method of selecting individuals from the population.
open class Selection<Chromosome: ChromosomeType> {
    
    public init() { }
    
    /**
     Select individuals from the population.
     
     - parameter generator:           Provider of randomness.
     - parameter population:          Population to select from.
     - parameter numberOfIndividuals: Number of individuals to select.
     
     - returns: Indices of the selected individuals.
     - warning: This method is abstract. You **must** implement it in a subclass.
     - precondition: `numberOfIndividuals <= population.populationSize`
     */
    open func select(_ generator: EntropyGenerator, population: MatingPool<Chromosome>, numberOfIndividuals: Int) -> IndexSet {
        preconditionFailure("This method must be implemented in a subclass.")
    }
    
}
