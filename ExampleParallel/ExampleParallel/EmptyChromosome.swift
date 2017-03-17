import Revolver

final class EmptyChromosome: CommonChromosomeType {
    
    // Empty chromosome contains nothing.
    
    init() {
        // Do nothing.
    }
    
    init(original: EmptyChromosome) {
        // Do nothing.
    }
    
    init(generator: EntropyGenerator) {
        // Do nothing.
    }
    
    func mutate(_ generator: EntropyGenerator) -> EmptyChromosome {
        return EmptyChromosome()
    }
    
    func onePointCrossover(_ generator: EntropyGenerator, other: EmptyChromosome) -> (first: EmptyChromosome, second: EmptyChromosome) {
        return (first: EmptyChromosome(), second: EmptyChromosome())
    }
    
}
