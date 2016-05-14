
/**
 *  Copyable types can generate deep copies of themselves.
 */
public protocol Copyable {
    
    /**
     Create a new instance of the same type, with the same values as another instance.
     
     - parameter original: The instance with values to copy.
     
     - returns: The new instance.
     */
    init(original: Self)
    
}
