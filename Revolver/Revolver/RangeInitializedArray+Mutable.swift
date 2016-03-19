
extension RangeInitializedArray: Mutable {
    
    public func mutate(generator: EntropyGenerator) -> RangeInitializedArray {
        // Generate random index and element to go there.
        let mutationIndex = generator.nextInRange(min: 0, max: array.count - 1)
        let randomElement = Element(generator: generator)
        
        // Prepare a new array of the same size.
        var newArray = Array<Element>()
        newArray.reserveCapacity(array.count)
        
        // Add the same elements except for the one at the mutation index.
        newArray.appendContentsOf(array[0..<mutationIndex])
        newArray.append(randomElement)
        newArray.appendContentsOf(array[(mutationIndex + 1)..<array.count])
        
        return RangeInitializedArray(array: newArray)
    }
    
}
