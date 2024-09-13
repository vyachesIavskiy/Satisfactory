import Foundation

public protocol Item: BaseItem {
    var category: Category { get }
}

public extension Sequence where Element: Item {
    func sortedByName() -> [Element] {
        sorted(using: KeyPathComparator(\.localizedName))
    }
    
    func sortedByCategory() -> [Element] {
        sorted(using: [KeyPathComparator(\.category), KeyPathComparator(\.localizedName)])
    }
}

public extension Array where Element: Item {
    mutating func sortByName() {
        self = sortedByName()
    }
}
