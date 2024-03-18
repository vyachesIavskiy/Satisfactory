import Foundation

public protocol BaseItem: Identifiable, Equatable {
    var id: String { get }
    var localizedName: String { get }
}

public extension BaseItem {
    var localizedName: String {
        "<LOCALIZE ME>"
    }
}

public extension Sequence where Element: BaseItem {
    func first(id: String) -> Element? {
        first { $0.id == id }
    }
}
