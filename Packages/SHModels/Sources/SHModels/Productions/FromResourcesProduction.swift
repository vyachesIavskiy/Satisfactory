import Foundation

public struct FromResourcesProduction: Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var asset: Asset
    public var statistics: Statistics
    // TODO: Add fields
    
    public init(id: UUID, name: String, asset: Asset, statistics: Statistics = Statistics()) {
        self.id = id
        self.name = name
        self.asset = asset
        self.statistics = statistics
    }
}
