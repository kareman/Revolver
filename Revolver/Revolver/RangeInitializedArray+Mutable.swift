
extension RangeInitializedArray {

    public func mutate(_ generator: EntropyGenerator) -> Self {
        // Generate random index and element to go there.
        let mutationIndex = generator.nextInRange(min: 0, max: array.count - 1)
        let randomElement = Element(generator: generator)

        // Prepare a new array of the same size.
        var newArray = [Element]()
        newArray.reserveCapacity(array.count)

        // Add the same elements except for the one at the mutation index.
        newArray.append(contentsOf: array[0..<mutationIndex])
        newArray.append(randomElement)
        newArray.append(contentsOf: array[(mutationIndex + 1)..<array.count])

        return Self(array: newArray)
    }
    
}
