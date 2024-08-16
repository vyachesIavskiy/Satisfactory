import Foundation

// MARK: Model

public struct Factory: Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var asset: Asset
    public var productionIDs: [UUID]
    
    public init(id: UUID, name: String, asset: Asset, productionIDs: [UUID]) {
        self.id = id
        self.name = name
        self.asset = asset
        self.productionIDs = productionIDs
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
