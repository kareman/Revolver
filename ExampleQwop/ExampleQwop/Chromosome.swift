import Revolver

final class Chromosome: RangeInitializedArray<Command>, Randomizable {
    required init(generator: EntropyGenerator) {
        super.init(generator: generator)
    }
    
    static func random(generator: EntropyGenerator) -> Chromosome {
        return Chromosome(generator: generator)
    }
    
    override func getInitializationRange() -> Range<Int> {
        return 0...50
    }
}
