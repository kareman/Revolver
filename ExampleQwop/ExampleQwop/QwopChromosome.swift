import Revolver

final class QwopChromosome: RangeInitializedArray {
    typealias Element = QwopCommand
    static let initializationRange = CountableRange<Int>(1...200)
    
    let array: [QwopCommand]
    
    required init(array: [QwopCommand]) {
        self.array = array
    }
    
    var description: String { return array.description }
    var debugDescription: String { return array.debugDescription }
    
    var programString: String {
        return array.reduce("", { $0 + String($1.rawValue) })
    }
}
