
/**
 *  Mutable type can be slightly non-deterministically altered.
 */
public protocol Mutable: ChromosomeType {
    
    /**
     Creates new instance by copying values of the current instance and changing them randomly.
     
     - parameter generator: Provider of randomness.
     
     - returns: New mutated instance.
     */
    func mutate(_ generator: EntropyGenerator) -> Self
    
}
