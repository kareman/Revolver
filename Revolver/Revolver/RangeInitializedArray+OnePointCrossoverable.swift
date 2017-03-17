
extension RangeInitializedArray {
    
    public func onePointCrossover(_ generator: EntropyGenerator, other: Self) -> (first: Self, second: Self) {
        // Choose one point in both arrays.
        let maxIndex = min(self.array.count, other.array.count) - 1
        let crossoverIndex = generator.nextInRange(min: 0, max: maxIndex)
        
        /*
         * Go from this:
         *  - self:   [-------A-------]
         *  - other:  [-------------B-------------]
         *
         * To this:
         *  - first:  [----A----|--------B--------]
         *  - second: [----B----|--A--]
         *                      ^~~~ This is the crossover index.
         */
        
        // Append the non-crossed segment.
        var firstOffspring = [Element](self.array[0..<crossoverIndex])
        var secondOffspring = [Element](other.array[0..<crossoverIndex])
        
        // Make sure we don't resize the arrays too often.
        firstOffspring.reserveCapacity(other.array.count)
        secondOffspring.reserveCapacity(self.array.count)
        
        // Append the crossed segment.
        firstOffspring.append(contentsOf: other.array[crossoverIndex..<other.array.count])
        secondOffspring.append(contentsOf: self.array[crossoverIndex..<self.array.count])
        
        return (first: Self(array: firstOffspring), second: Self(array: secondOffspring))
    }
    
}
