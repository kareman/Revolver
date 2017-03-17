import Revolver

final class DoubleArray: RangeInitializedArray {

    typealias Element = Double
    static let initializationRange = CountableRange<Int>(42...42)
    
    let array: [Double]
    
    required init(array: [Double]) {
        self.array = array
    }
    
    var description: String { return array.description }
    var debugDescription: String { return array.debugDescription }
}
