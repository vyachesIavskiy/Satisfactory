import Foundation

// MARK: Model

public struct Factory: Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var creationDate: Date
    public var asset: Asset
    public var productionIDs: [UUID]
    
    public init(id: UUID, name: String, creationDate: Date, asset: Asset, productionIDs: [UUID]) {
        self.id = id
        self.name = name
        self.creationDate = creationDate
        self.asset = asset
        self.productionIDs = productionIDs
    }
}

public extension Sequence<Factory> {
    func first(id: UUID) -> Element? {
        first { $0.id == id }
    }
    
    func sortedByDate() -> [Factory] {
        sorted(using: KeyPathComparator(\.creationDate, order: .reverse))
    }
    
    func sortedByName() -> [Factory] {
        sorted(using: KeyPathComparator(\.name))
    }
}

public extension Collection<Factory> {
    func firstIndex(id: UUID) -> Index? {
        firstIndex { $0.id == id }
    }
}
