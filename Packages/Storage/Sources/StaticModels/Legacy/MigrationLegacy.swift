import Foundation

public struct MigrationLegacy: Decodable {
    public let version: Int
    public let partIDs: [IDs]
    public let equipmentIDs: [IDs]
    public let recipeIDs: [IDs]
}

public extension MigrationLegacy {
    struct IDs: Decodable {
        public let oldID: String
        public let newID: String
    }
}

extension MigrationLegacy: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.version == rhs.version
    }
}

extension MigrationLegacy: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.version < rhs.version
    }
}

public extension Sequence where Element == MigrationLegacy.IDs {
    func first(oldID: String) -> Element? {
        first { $0.oldID == oldID }
    }
    
    func first(newID: String) -> Element? {
        first { $0.newID == newID }
    }
}

public extension Collection where Element == MigrationLegacy.IDs {
    func firstIndex(oldID: String) -> Index? {
        firstIndex { $0.oldID == oldID }
    }
    
    func firstIndex(newID: String) -> Index? {
        firstIndex { $0.newID == newID }
    }
}
