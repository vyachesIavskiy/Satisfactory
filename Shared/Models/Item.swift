import Foundation

protocol Item {
    var id: String { get }
    var name: String { get }
    var recipes: [Recipe] { get }
}
