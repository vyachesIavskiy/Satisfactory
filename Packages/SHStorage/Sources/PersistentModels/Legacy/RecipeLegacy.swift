import Foundation
import Models

extension Recipe.Persistent {
    public struct Legacy: Decodable {
        public let id: String
        public let isPinned: Bool
        //TODO: Is ingredient missing?
        
        public init(id: String, isPinned: Bool) {
            self.id = id
            self.isPinned = isPinned
        }
    }
}

extension Recipe.Persistent.Legacy {
    public struct Ingredient: Decodable {
        public let id: String
        public let amount: Double
        
        public init(id: String, amount: Double) {
            self.id = id
            self.amount = amount
        }
    }
}
