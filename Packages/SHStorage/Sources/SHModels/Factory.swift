import Foundation

// MARK: Model

public struct Factory: Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var assetType: AssetType
    public var productionIDs: [UUID]
    
    public init(id: UUID, name: String, assetType: AssetType, productionIDs: [UUID]) {
        self.id = id
        self.name = name
        self.assetType = assetType
        self.productionIDs = productionIDs
    }
}

extension Factory {
    public enum AssetType: Hashable, Sendable {
        case legacy
        case abbreviation
        case assetCatalog(name: String)
    }
}

public extension Sequence<Factory> {
    func first(id: UUID) -> Element? {
        first { $0.id == id }
    }
}

public extension Collection<Factory> {
    func firstIndex(id: UUID) -> Index? {
        firstIndex { $0.id == id }
    }
}
