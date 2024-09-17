import Foundation

@dynamicMemberLookup
public struct Production: Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var creationDate: Date
    public var assetName: String
    public var content: Content
    
    public init(id: UUID, name: String, creationDate: Date, assetName: String, content: Content) {
        self.id = id
        self.name = name
        self.creationDate = creationDate
        self.assetName = assetName
        self.content = content
    }
    
    public subscript<T>(dynamicMember keyPath: KeyPath<Content, T>) -> T {
        content[keyPath: keyPath]
    }
}

// MARK: Production + Sequence
public extension Sequence<Production> {
    func first(id: UUID) -> Element?  {
        first { $0.id == id }
    }
    
    func sortedByDate() -> [Production] {
        sorted(using: KeyPathComparator(\.creationDate, order: .reverse))
    }
    
    func sortedByName() -> [Production] {
        sorted(using: KeyPathComparator(\.name))
    }
}

// MARK: Production + Collection
public extension Collection<Production> {
    func firstIndex(id: UUID) -> Index? {
        firstIndex { $0.id == id }
    }
}
