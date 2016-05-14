
public extension RangeInitializedArray {
    
    public init(original: Self) {
        // Arrays have value semantics in Swift.
        self.init(array: original.array)
    }
    
}