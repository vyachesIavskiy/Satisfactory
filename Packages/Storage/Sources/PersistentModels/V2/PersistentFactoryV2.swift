import Foundation

public struct PersistentFactoryV2: Codable, Identifiable {
    public var id: UUID
    public var name: String
    public var productionIDs: [UUID]
    
    public init(id: UUID, name: String, productionIDs: [UUID]) {
        self.id = id
        self.name = name
        self.productionIDs = productionIDs
    }
}
