import Foundation

public protocol Item: BaseItem {
    var category: Category { get }
    var localizedDescription: String { get }
}

public extension Item {
    var localizedDescription: String {
        NSLocalizedString(id, tableName: "Descriptions", bundle: .module, comment: "")
    }
}

public extension Sequence where Element: Item {
    func sortedByName() -> [Element] {
        sorted(using: KeyPathComparator(\.localizedName))
    }
}

public extension Array where Element: Item {
    mutating func sortByName() {
        self = sortedByName()
    }
}
