import Revolver

/// MAX-ONE chromosome is a conventional bit string.
final class MaxOneChromosome: RangeInitializedArray {
    typealias Element = Bool
    static let initializationRange = 10...Configuration.maxNumberOfOnes
    
    let array: [Bool]
    
    required init(array: [Bool]) {
        self.array = array
    }
    
    var description: String { return array.description }
    var debugDescription: String { return array.debugDescription }
    
    // This is just convenience method for writing out long arrays of Booleans.
    var bitString: String {
        var string = ""
        for bool in array {
            string += bool ? "1" : "0"
        }
        
        return string
    }
}
