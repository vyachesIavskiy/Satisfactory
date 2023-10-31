import Foundation

public struct PersistentRecipeLegacy: Decodable {
    public let id: String
    public let isPinned: Bool
    
    public init(id: String, isPinned: Bool) {
        self.id = id
        self.isPinned = isPinned
    }
}

public extension PersistentRecipeLegacy {
    struct Ingredient: Decodable {
        public let id: String
        public let amount: Double
        
        public init(id: String, amount: Double) {
            self.id = id
            self.amount = amount
        }
    }
}
