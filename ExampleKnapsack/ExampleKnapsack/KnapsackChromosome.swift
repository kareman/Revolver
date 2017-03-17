import Revolver

final class KnapsackChromosome: RangeInitializedArray {
    typealias Element = Bool
    static let initializationRange = CountableRange<Int>(10...10)
    
    let array: [Bool]
    
    required init(array: [Bool]) {
        self.array = array
    }
    
    var description: String { return array.description }
    var debugDescription: String { return array.debugDescription }
}
