import Foundation
import Models

extension Production.Persistent {
    public struct V2: Codable, Identifiable {
        public var id: UUID
        public var name: String
        public var itemID: String
        public var amount: Double
        // TODO: Figure out production structure
        
        public init(id: UUID, name: String, itemID: String, amount: Double) {
            self.id = id
            self.name = name
            self.itemID = itemID
            self.amount = amount
        }
    }
}
