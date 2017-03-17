
extension RangeInitializedArray {
    
    public init(generator: EntropyGenerator) {
        // Determine the length of the array.
        let size: Int
            
        if Self.initializationRange.lowerBound + 1 == Self.initializationRange.upperBound {
            size = Self.initializationRange.lowerBound
        } else {
            size = generator.nextInRange(Range(Self.initializationRange))
        }

        // Prepare the underlying data structure.
        var array = [Element]()
        array.reserveCapacity(size)
        
        for _ in 0..<size {
            array.append(generator.next())
        }
        
        self.init(array: array)
    }
    
}
