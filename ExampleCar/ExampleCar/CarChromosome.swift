import Revolver

struct NeuralNetWeight: Randomizable, CustomStringConvertible, CustomDebugStringConvertible {
    let weight: Float
    
    init(_ weight: Float) {
        self.weight = weight
    }
    
    init(generator: EntropyGenerator) {
        // Generate Float between +/- 1/sqrt(numInputNodes).
        // This interval is optimal for sigmoid activation.
        
        let bound = Float(1) / sqrt(Float(5))
        self.weight = generator.nextInRange(min: -bound, max: bound)
    }
    
    var description: String { return weight.description }
    var debugDescription: String { return weight.debugDescription }
}

final class CarChromosome: RangeInitializedArray {
    typealias Element = NeuralNetWeight
    static let initializationRange = 82...82
    
    let array: [NeuralNetWeight]
    
    required init(array: [NeuralNetWeight]) {
        self.array = array
    }
    
    var description: String { return array.description }
    var debugDescription: String { return array.debugDescription }
    
    func toFFNN() -> FFNN {
        return FFNN(inputs: 5,
                    hidden: 10,
                    outputs: 2,
                    weights: array.map { $0.weight },
                    activationFunction: .Sigmoid)
    }
}
