import Foundation

public struct PowerProduction: Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var assetName: String
    public var statistics: Statistics
    // TODO: Add fields
    
    public init(id: UUID, name: String, assetName: String, statistics: Statistics = Statistics()) {
        self.id = id
        self.name = name
        self.assetName = assetName
        self.statistics = statistics
    }
}
