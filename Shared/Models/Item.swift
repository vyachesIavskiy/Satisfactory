import Foundation

protocol Item {
    var id: String { get }
    var name: String { get }
}

extension Array where Element: Item {
    func first(item: Item) -> Item? {
        first { $0.id == item.id }
    }
}
