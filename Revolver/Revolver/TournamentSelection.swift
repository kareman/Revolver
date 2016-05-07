
/// Tournament selection.
/// For more information, see [the article on Wikipedia](https://en.wikipedia.org/wiki/Tournament_selection).
public class TournamentSelection<Chromosome: Randomizable>: Selection<Chromosome> {
    
    /// Random selection used for the subselection within every tournament.
    private var randomSelection: RandomSelection<Chromosome>
    
    /// Order of the tournament, also known as the *Tour*.
    public let tournamentOrder: Int
    
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
    
    public override func select(generator: EntropyGenerator, population: MatingPool<Chromosome>, numberOfIndividuals: Int) -> IndexSet {
        precondition(numberOfIndividuals <= population.populationSize, "The number of individuals to select is greater than the number of individuals available.")

        var winners = IndexSet()
        for _ in 0..<numberOfIndividuals {
            // Select K individuals at random.
            let competitors = randomSelection.select(generator, population: population, numberOfIndividuals: tournamentOrder)
            
            // Add the winner to selection.
            let winner = competitors.maxElement { population.individualAtIndex($0).fitness! < population.individualAtIndex($1).fitness! }
            winners.append(winner!)
        }
        
        return winners
    }

}
