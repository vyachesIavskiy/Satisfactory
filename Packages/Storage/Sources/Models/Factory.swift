import Foundation

public struct Factory {
    public var id: UUID
    public var name: String
    public var productions: [Production]
    
    public init(id: UUID, name: String, productions: [Production]) {
        self.id = id
        self.name = name
        self.productions = productions
    }
}
