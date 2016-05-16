import SwiftyJSON

public protocol PersistentType {
    
    init(json: JSON)
    
    func toJSON() -> JSON
    
}
