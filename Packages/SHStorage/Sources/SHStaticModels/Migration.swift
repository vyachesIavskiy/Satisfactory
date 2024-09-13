import Foundation

package struct Migration: Codable {
    package var version: Int
    package var partIDs: [IDs]
    package var recipeIDs: [IDs]
}

package extension Migration {
    struct IDs: Codable {
        package var oldID: String
        package var newID: String
    }
}

extension Migration: Equatable {
    package static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.version == rhs.version
    }
}

extension Migration: Comparable {
    package static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.version < rhs.version
    }
}

package extension Sequence where Element == Migration.IDs {
    func first(oldID: String) -> Element? {
        first { $0.oldID == oldID }
    }
    
    func first(newID: String) -> Element? {
        first { $0.newID == newID }
    }
}

package extension Collection where Element == Migration.IDs {
    func firstIndex(oldID: String) -> Index? {
        firstIndex { $0.oldID == oldID }
    }
    
    func firstIndex(newID: String) -> Index? {
        firstIndex { $0.newID == newID }
    }
}
