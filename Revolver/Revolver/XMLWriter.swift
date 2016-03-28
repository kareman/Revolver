
/**
 *  Writer of XML-formatted data (using SAX-style interface).
 */
public protocol XMLWriter {
    
    /**
     Write beginning of a new XML document.
     
     - parameter encoding: Encoding of the document.
     - parameter version:  Version of XML.
     
     - precondition: A document must be closed (by initializing the writer or calling `endDocument()`).
     */
    func startDocument(encoding encoding: String, version: String)
    
    /**
     Write beginning of a new XML element.
     
     - parameter qualifiedName: Qualified name of the element.
     */
    func startElement(qualifiedName: String)
    
    /**
     Write beginning of a new XML element.
     
     - parameter namespace: Namespace of the element.
     - parameter localName: Local name of the element.
     */
    func startElement(namespace namespace: String, localName: String)
    
    /**
     Write characters of the element text.
     
     - parameter characters: Characters to write.
     
     - precondition: An element must be opened (by calling `startElement()`).
     */
    func writeCharacters(characters: String)
    
    /**
     Close last opened XML element.
     
     - precondition: An element must be opened (by calling `startElement()`).
     */
    func endElement()
    
    /**
     Write attribute of an XML element.
     
     - parameter qualifiedName: Qualified name of the attribute.
     - parameter value:         Value of the attribute.
     
     - precondition: An element must be opened (by calling `startElement()`) and none of its contents must have been written.
     */
    func writeAttribute(qualifiedName: String, value: String)
    
    /**
     Write attribute of an XML element.
     
     - parameter namespace: Namespace of tha attribute.
     - parameter localName: Local name of the attribute.
     - parameter value:     Value of the attribute.
     */
    func writeAttribute(namespace namespace: String, localName: String, value: String)
    
    /**
     Close current XML document.
     
     - precondition: A document must be opened (by calling `startDocument()`.
     */
    func endDocument()
    
}
