import Foundation
import SHModels

extension Building {
    package struct Static: Codable {
        package let id: String
        package let categoryID: String
        
        package init(id: String, categoryID: String) {
            self.id = id
            self.categoryID = categoryID
        }
    }
    
    package init(_ building: Static) throws {
        try self.init(id: building.id, category: Category(fromID: building.categoryID))
    }
}
