import Foundation
import SHModels

extension Part.Persistent {
    package struct Legacy: Decodable {
        package let id: String
        package let isFavorite: Bool
        
        package init(id: String, isFavorite: Bool) {
            self.id = id
            self.isFavorite = isFavorite
        }
    }
}
