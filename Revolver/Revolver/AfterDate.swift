
/// Terminate the genetic algorithm after a point in time is reached.
open class AfterDate<Chromosome: ChromosomeType>: TerminationCondition<Chromosome> {
    
    /// Point in time, after which to terminate the algorithm.
    open let date: Date
    
    /**
     Terminate the genetic algorithm after a point in time is reached.
     
     - parameter date: Point in time, after which to terminate the algorithm.
     
     - returns: New termination condition.
     */
    public init(_ date: Date) {
        self.date = date
        super.init()
    }
    
    open override func shouldTerminate(_ population: MatingPool<Chromosome>) -> Bool {
        let now = Date()
        return now > date
    }
    
}
