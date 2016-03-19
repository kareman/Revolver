
/// Array of elements, which is initialized to size within a specific range.
public final class RangeInitializedArray<Element: Randomizable> {
    
    /// Provides direct access to the generated values.
    public var array: [Element] = []
    
    /**
     Initializes new array with pseudorandom values.
     
     - parameter generator: Provider of randomness.
     
     - returns: New instance of array.
     */
    public required init(generator: EntropyGenerator) {
        let range = self.getInitializationRange()
        let size: Int = generator.nextInRange(range)
        
        array = []
        for _ in 0..<size {
            array.append(generator.next())
        }
    }
    
    /**
     Initializes new array with given value.
     
     - parameter array: Initial value of the array.
     
     - returns: New instance of array.
     */
    init(array: [Element]) {
        self.array = array
    }
    
    /**
     Method determining the size range of new array.
     This method **must** be implemented in subclasses.
     
     - returns: Constant range from which the size is chosen at random.
     */
    public func getInitializationRange() -> Range<Int> {
        preconditionFailure("This method must be overridden in a subclass.")
    }
    
}
