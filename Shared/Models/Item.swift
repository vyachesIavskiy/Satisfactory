import Foundation

protocol Item {
    var id: String { get }
    var name: String { get }
    var imageName: String { get }
    var isFavorite: Bool { get set }
}

extension Array where Element: Item {
    func first(item: Item) -> Element? {
        first { $0.id == item.id }
    }
    
    func first(id: String) -> Element? {
        first { $0.id == id }
    }
    
    func firstIndex(of id: String) -> Index? {
        firstIndex { $0.id == id }
    }
}
