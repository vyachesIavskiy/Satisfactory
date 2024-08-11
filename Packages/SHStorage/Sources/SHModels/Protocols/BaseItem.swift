import Foundation

public protocol BaseItem: Identifiable, Hashable, Sendable, CustomStringConvertible {
    var id: String { get }
    var localizedName: String { get }
}

public extension BaseItem {
    var localizedName: String {
        NSLocalizedString(id, tableName: "Names", bundle: .module, comment: "")
    }
}

public extension Sequence where Element: BaseItem {
    func first(id: String) -> Element? {
        first { $0.id == id }
    }
}

public extension Sequence<any BaseItem> {
    func first(id: String) -> Element? {
        first { $0.id == id }
    }
}
