
/// Elitism copies the best individuals before transitioning between iterations to ensure that the solution does not worsen.
open class Elitism<Chromosome: Reproducible>: Reproduction<Chromosome> {
    
    public init(numberOfIndividuals: Int = 1) {
        super.init(BestSelection(), numberOfIndividuals: numberOfIndividuals)
    }
    
}
