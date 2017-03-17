
extension RangeInitializedArray {
    
    public func twoPointCrossover(_ generator: EntropyGenerator, other: Self) -> (first: Self, second: Self) {
        // Choose two points in both arrays.
        let maxIndex = min(self.array.count, other.array.count) - 1
        let firstCrossoverIndex = generator.nextInRange(min: 0, max: maxIndex - 1)
        let secondCrossoverIndex = generator.nextInRange(min: firstCrossoverIndex + 1, max: maxIndex)
        
        /*
         * Go from this:
         *  - self:   [-------A-----------]
         *  - other:  [-------------B-----------------]
         *
         * To this:
         *  - first:  [--A--|-B-|----A----]
         *  - second: [--B--|-A-|----------B----------]
         *                  ^~~~^~~~ This are the 1st and the 2nd crossover index.
         */
        
        // Append the non-crossed segment.
        var firstOffspring = [Element](self.array[0..<firstCrossoverIndex])
        var secondOffspring = [Element](other.array[0..<firstCrossoverIndex])
        
        // Make sure we don't resize the arrays too often.
        firstOffspring.reserveCapacity(self.array.count)
        secondOffspring.reserveCapacity(other.array.count)
        
        // Append the crossed segment.
        firstOffspring.append(contentsOf: other.array[firstCrossoverIndex..<secondCrossoverIndex])
        secondOffspring.append(contentsOf: self.array[firstCrossoverIndex..<secondCrossoverIndex])
        
        // Append the rest of the arrays.
        firstOffspring.append(contentsOf: self.array[secondCrossoverIndex..<self.array.count])
        secondOffspring.append(contentsOf: other.array[secondCrossoverIndex..<other.array.count])
        
        return (first: Self(array: firstOffspring), second: Self(array: secondOffspring))
    }
    
}
