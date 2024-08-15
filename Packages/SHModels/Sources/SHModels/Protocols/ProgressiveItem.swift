import Foundation

public protocol ProgressiveItem: Item {
    var progressionIndex: Int { get }
}

public extension Sequence where Element: ProgressiveItem {
    func sortedByProgression() -> [Element] {
        sorted(using: KeyPathComparator(\.progressionIndex))
    }
}

public extension Array where Element: ProgressiveItem {
    mutating func sortByProgression() {
        self = sortedByProgression()
    }
}
