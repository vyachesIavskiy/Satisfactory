import Foundation

public struct Production {
    public var id: UUID
    public var name: String
    public var item: Item
    public var amount: Double
    // TODO: Declare production internal structure
    
    public init(id: UUID, name: String, item: Item, amount: Double) {
        self.id = id
        self.name = name
        self.item = item
        self.amount = amount
    }
}
