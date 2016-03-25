
public class PopulationPool<Chromosome: Randomizable> {
    
    public typealias IndividualType = Individual<Chromosome>
    
    internal var currentGeneration: Int = 0
    
    internal var pool: [IndividualType] = []
    internal var stagingPool: [IndividualType]? = nil
    
    public func addIndividualToNextGeneration(individual: IndividualType) {
        guard stagingPool != nil else {
            preconditionFailure("This method can be called only after startStagingNextGeneration() is called.")
        }
        
        stagingPool!.append(individual)
    }
    
    public func startStagingNextGeneration() {
        guard stagingPool == nil else {
            preconditionFailure("This method can be called only after initialization or after upgradeGeneration() is called.")
        }
        
        stagingPool = []
    }
    
    public func upgradeGeneration() {
        guard let newPool = stagingPool else {
            preconditionFailure("This method can be called only after startStagingNextGeneration() is called.")
        }
        
        pool = newPool
        stagingPool = nil
        currentGeneration += 1
    }
    
    public func retrieveChromosome(index: Int) -> Chromosome {
        return pool[index].chromosome
    }
    
    public func cloneIndividual(index: Int) -> IndividualType {
        return IndividualType(original: pool[index])
    }
    
}
