
/* This is an example of usage of the RangeInitializedArray protocol.
 * It is made "internal" not to conflict with other objects in the library.
 *
 * If you are going to use it, you will have to define a similar struct with your configuration within your app.
 * This is due to the fact that Swift does not allow any better solution (abstract classes anyone?).
 */

internal struct RangeInitializedArrayExample: RangeInitializedArray {
    // CONFIGURATION: You will want to change this. Currently it's set to array of N booleans, where N is from the [26;42] interval.
    internal typealias Element = Bool
    internal static let initializationRange = CountableRange<Int>(26...42)
    // END CONFIGURATION
    
    // The rest of the file you can just ⌘C, ⌘V into your app.
    
    internal let array: [Element]
    
    internal init(array: [Element]) {
        self.array = array
    }
    
}
