
/// Tournament selection.
/// For more information, see [the article on Wikipedia](https://en.wikipedia.org/wiki/Tournament_selection).
open class TournamentSelection<Chromosome: ChromosomeType>: Selection<Chromosome> {
    
    /// Random selection used for the subselection within every tournament.
    fileprivate var randomSelection: RandomSelection<Chromosome>
    
    /// Order of the tournament, also known as the *Tour*.
    open let tournamentOrder: Int
    
    /**
     Constructs new tournament selection object.
     
     - parameter order:     Order of the tournament, also known as the *Tour*.
     
     - returns: New instance of the tournament selection object.
     */
    public init(order: Int) {
        self.tournamentOrder = order
        self.randomSelection = RandomSelection<Chromosome>()
        super.init()
    }
    
    open override func select(_ generator: EntropyGenerator, population: MatingPool<Chromosome>, numberOfIndividuals: Int) -> IndexSet {
        precondition(numberOfIndividuals <= population.populationSize, "The number of individuals to select is greater than the number of individuals available.")

        var winners = IndexSet()
        for _ in 0..<numberOfIndividuals {
            // Select K individuals at random.
            let competitors = randomSelection.select(generator, population: population, numberOfIndividuals: tournamentOrder)
            
            // Add the winner to selection.
            let winner = competitors.max { population.individualAtIndex($0).fitness! < population.individualAtIndex($1).fitness! }
            winners.append(winner!)
        }
        
        return winners
    }

}
