import Foundation

public struct FromResourcesProduction: Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var asset: Asset
    // TODO: Add fields
    
    public init(id: UUID, name: String, asset: Asset) {
        self.id = id
        self.name = name
        self.asset = asset
    }
}
