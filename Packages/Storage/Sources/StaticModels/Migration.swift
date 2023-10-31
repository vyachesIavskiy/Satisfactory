import Foundation

public struct Migration: Codable {
    public let version: Int
    public var partIDs: [IDs]
    public var equipmentIDs: [IDs]
    public var recipeIDs: [IDs]
}

public extension Migration {
    struct IDs: Codable {
        public var oldID: String
        public var newID: String
    }
}

extension Migration: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.version == rhs.version
    }
}

extension Migration: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.version < rhs.version
    }
}

public extension Sequence where Element == Migration.IDs {
    func first(oldID: String) -> Element? {
        first { $0.oldID == oldID }
    }
    
    func first(newID: String) -> Element? {
        first { $0.newID == newID }
    }
}

public extension Collection where Element == Migration.IDs {
    func firstIndex(oldID: String) -> Index? {
        firstIndex { $0.oldID == oldID }
    }
    
    func firstIndex(newID: String) -> Index? {
        firstIndex { $0.newID == newID }
    }
}
