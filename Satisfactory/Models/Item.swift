import Foundation

protocol Item {
    var id: UUID { get }
    var name: String { get }
    var recipes: [Recipe] { get }
}
