import Foundation
import SHModels

extension Recipe.Persistent {
    public struct Legacy: Decodable {
        public let id: String
        public let isFavorite: Bool
        
        public init(id: String, isFavorite: Bool) {
            self.id = id
            self.isFavorite = isFavorite
        }
    }
}
