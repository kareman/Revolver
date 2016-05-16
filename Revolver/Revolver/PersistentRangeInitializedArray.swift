
public protocol PersistentRangeInitializedArray: RangeInitializedArray, PersistentChromosomeType {
    
    associatedtype Element: Randomizable, PersistentType
    
}
