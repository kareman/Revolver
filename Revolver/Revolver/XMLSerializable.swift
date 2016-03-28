
/**
 *  Type which can be stored and loaded from the XML format.
 */
public protocol XMLSerializable {
    
    /**
     Saves the type in the XML format.
     
     - parameter writer: Writer used to create XML data.
     */
    func write(writer: XMLWriter)
    
    /**
     Loads previously serialized instance from the XML format.
     
     - parameter reader: Reader used to parse XML data.
     
     - returns: Instance initialized using values obtained by `reader`.
     */
    init(reader: XMLElement)
    
}