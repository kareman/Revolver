
extension Array: OnePointCrossoverable {
    
    public func onePointCrossover(generator: EntropyGenerator, other: Array) -> (first: Array, second: Array) {
        // Choose one point in both arrays.
        let maxIndex = min(self.count, other.count) - 1
        let crossoverIndex = generator.nextInRange(min: 0, max: maxIndex)
        
        var firstOffspring = Array()
        var secondOffspring = Array()
        
        // Make sure we don't resize the arrays too often.
        firstOffspring.reserveCapacity(other.count)
        secondOffspring.reserveCapacity(self.count)
        
        /*
         * Go from this:
         *  - self:   [-------A-------]
         *  - other:  [-------------B-------------]
         *
         * To this:
         *  - first:  [----A----|--------B--------]
         *  - second: [----B----|--A--]
         */
        
        // Append the non-crossed segment.
        firstOffspring.appendContentsOf(self[0..<crossoverIndex])
        secondOffspring.appendContentsOf(other[0..<crossoverIndex])
        
        // Append the crossed segment.
        firstOffspring.appendContentsOf(other[crossoverIndex..<other.count])
        secondOffspring.appendContentsOf(self[crossoverIndex..<self.count])
        
        return (first: firstOffspring, second: secondOffspring)
    }
    
}
