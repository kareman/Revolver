
/**
 *  Attribute of a XML element.
 */
public protocol XMLAttribute {
    
    /// Namespace of the attribute.
    var namespace: String? { get }
    
    /// Local name of the attribute.
    var localName: String { get }
    
    /// Qualified name of the attribute.
    var qualifiedName: String { get }
    
    /// Value of the attribute.
    var value: String { get }
    
}
