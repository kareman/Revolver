
/// Random selection method, uninfluenced by any property of the individuals.
public class RandomSelection: Selection {
    
    /// Maximum index in the population.
    private var maxPopulationIndex: Int = 0
    
    // MARK: Implementation of abstract methods.
    
    /**
     This method shall be called when the population pool changes.
     The selection object uses it to update the allowed range from which the individuals are then selected.
    
     - parameter population: Population to select from.
                             It is guaranteed that at the time of calling this method, the `fitness` property
                             of all individuals in the population is not equal to `nil`.
     */
    public override func prepareForNewPopulation(population: [FitnessType]) {
        maxPopulationIndex = population.count - 1
        prepared = true
    }
    
    /**
     This method shall be called when the selection occurs.
     It triggers a single batch of uniform random selections, resulting in the returned set of indices.
     
     - returns: Set of indices corresponding with selected individuals in the population.
     */
    public override func select() -> IndexSet {
        precondition(prepared, "The method select() was called on an unprepared Selection object. Call prepareForNewPopulation() first.")
        
        var foundIndexSet = IndexSet()
        for _ in 0..<numberOfIndividuals {
            // Generate random index and add it to set.
            let selectedIndex: Int = entropyGenerator.nextInRange(min: 0, max: maxPopulationIndex)
            foundIndexSet.append(selectedIndex)
        }
        
        return foundIndexSet
    }
    
}
