
/**
 *  Single element in a XML document.
 */
public protocol XMLElement {
    
    /// Namespace of the element.
    var namespace: String? { get }
    
    /// Local name of the element.
    var localName: String { get }
    
    /// Qualified name of the element.
    var qualifiedName: String { get }
    
    /// Number of child elements.
    var numberOfChildren: Int { get }
    
    /**
     Retrieve child element at specified index.
     
     - parameter index: Index of the child element.
     
     - returns: Child element at the specified index.
     */
    func childAtIndex(index: Int) -> XMLElement
    
    /// Number of element's attributes.
    var numberOfAttributes: Int { get }
    
    /**
     Retrieve attribute of the element at a specified index.
     
     - parameter index: Index of the attribute.
     
     - returns: Attribute at the specified index.
     */
    func attributeAtIndex(index: Int) -> XMLAttribute
    
    /**
     Retrieve attribute of the element by its name.
     
     - parameter qualifiedName: Qualified name of the attribute.
     
     - returns: Attribute with the specified name. If not found, the value is `nil`.
     */
    func attributeForName(qualifiedName: String) -> XMLAttribute?
    
}
