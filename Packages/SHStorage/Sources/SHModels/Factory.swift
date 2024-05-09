import Foundation

// MARK: Model

public struct Factory: Equatable {
    public var id: UUID
    public var name: String
    public var image: Image
    public var productions: [Production]
    
    public init(id: UUID, name: String, productions: [Production]) {
        self.id = id
        self.name = name
        self.image = .abbreviation
        self.productions = productions
    }
    
    public init(id: UUID, name: String, assetName: String, productions: [Production]) {
        self.id = id
        self.name = name
        self.image = .asset(name: assetName)
        self.productions = productions
    }
}

extension Factory {
    public enum Image: Equatable {
        case abbreviation
        case asset(name: String)
    }
}

public extension Collection<Factory> {
    func first(id: UUID) -> Element? {
        first { $0.id == id }
    }
    
    func firstIndex(id: UUID) -> Index? {
        firstIndex { $0.id == id }
    }
}
