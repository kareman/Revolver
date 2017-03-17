
/// Array of elements, which is initialized to an uncertain size.
///
/// When conforming to this protocol, do not implement any of its inherited protocols.
/// They have been already implemented by extensions.
///
/// In the initializer, merely assign the argument to its field counterpart.
/// You may configure the element type and size constraints by setting `Element` and `initializationRange`.
/// Example of this can be seen in the `RangeInitializedArrayExample` class.
public protocol RangeInitializedArray: CustomStringConvertible, CustomDebugStringConvertible, CommonChromosomeType, TwoPointCrossoverable {
    
    /// Homogeneous type of elements in the array.
    associatedtype Element: Randomizable
    
    /// Constant range from, which the size is chosen at random.
    /// PRO TIP: Set the range to a single number (e. g. 42...42) to get array of a fixed size.
    static var initializationRange: CountableRange<Int> { get }
    
    /// Provides direct access to the generated values.
    var array: [Element] { get }
    
    /**
     Initialize a new array with given values.

     - parameter array: Values of the array.

     - returns: New instance of array.
     */
    init(array: [Element])
    
}
