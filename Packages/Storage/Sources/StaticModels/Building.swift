import Foundation

public struct Building: Codable {
    public let id: String
    public let categoryID: String
    
    public init(id: String, categoryID: String) {
        self.id = id
        self.categoryID = categoryID
    }
}
