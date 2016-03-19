
/// Tournament selection.
/// For more information, see [Wikipedia](https://en.wikipedia.org/wiki/Tournament_selection).
public class TournamentSelection: Selection {
    
    /// Latest snapshot of the current fitness values.
    internal var currentFitnessValues: [Double] = []
    
    /// Random selection used for the subselection within every tournament.
    internal var randomSelection: RandomSelection
    
    // Order of the tournament, also known as the *Tour*.
    internal let tournamentOrder: Int
    
    /**
     Constructs new tournament selection object.
     
     - parameter numberOfIndividuals: Number of individuals to select.
     - parameter generator:           Provider of randomness.
     - parameter tournamentOrder:     Order of the tournament, also known as the *Tour*.
     
     - returns: New instance of the tournament selection object.
     */
    public init(numberOfIndividuals: Int, generator: EntropyGenerator, tournamentOrder: Int) {
        self.tournamentOrder = tournamentOrder
        self.randomSelection = RandomSelection(numberOfIndividuals: tournamentOrder, generator: generator)
        
        super.init(numberOfIndividuals: numberOfIndividuals, generator: generator)
    }
    
    // MARK: Implementation of abstract methods.
    
    /**
     This method shall be called when the population pool changes.
     The selection object uses it to create snapshot of the current population.
    
     - parameter population: Population to select from.
                             It is guaranteed that at the time of calling this method, the `fitness` property
                             of all individuals in the population is not equal to `nil`.
    */
    public override func prepareForNewPopulation(population: [FitnessType]) {
        currentFitnessValues = population.map { $0.fitness! }
        randomSelection.prepareForNewPopulation(population)
        prepared = true
    }
    
    /**
     This method shall be called when the selection occurs.
     It is equivalent to a single batch of tournaments.
     
     - returns: Set of indices corresponding with selected individuals in the population.
     */
    public override func select() -> IndexSet {
        precondition(prepared, "The method select() was called on an unprepared Selection object. Call prepareForNewPopulation() first.")
        
        var foundIndices = IndexSet()
        for _ in 0..<numberOfIndividuals {
            // Select K individuals at random.
            let competitors = randomSelection.select()
            
            // Add the winner to selection.
            let winner = competitors.maxElement { self.currentFitnessValues[$0] < self.currentFitnessValues[$1] }
            foundIndices.append(winner!)
        }
        
        return foundIndices
    }

}
