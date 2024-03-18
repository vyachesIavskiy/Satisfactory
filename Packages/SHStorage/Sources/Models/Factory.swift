import Foundation

// MARK: Model

public struct Factory: Equatable {
    public var id: UUID
    public var name: String
    public var productions: [Production]
    
    public init(id: UUID, name: String, productions: [Production]) {
        self.id = id
        self.name = name
        self.productions = productions
    }
}

public extension Collection where Element == Factory {
    func first(id: UUID) -> Element? {
        first { $0.id == id }
    }
    
    func firstIndex(id: UUID) -> Index? {
        firstIndex { $0.id == id }
    }
}

// MARK: Persistent

extension Factory {
    enum Persistent {
        struct V2: Codable, Identifiable {
            var id: UUID
            var name: String
            var productionIDs: [UUID]
        }
    }
}
