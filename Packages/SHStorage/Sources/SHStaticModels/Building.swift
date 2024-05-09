import Foundation
import SHModels

extension Building {
    public struct Static: Codable {
        public let id: String
        public let categoryID: String
        
        public init(id: String, categoryID: String) {
            self.id = id
            self.categoryID = categoryID
        }
    }
    
    public init(_ building: Static) throws {
        try self.init(id: building.id, category: Category(fromID: building.categoryID))
    }
}
