import Foundation

public struct PersistentProductionV2: Codable, Identifiable {
    public var id: UUID
    public var name: String
    public var itemID: String
    public var amount: Double
    // TODO: Figure out production structure
}
