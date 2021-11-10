import Foundation

protocol Item {
    var id: String { get }
    var name: String { get }
}

extension CustomStringConvertible where Self: Item {
    var description: String { name }
}

extension Item {
    var recipes: [Recipe] {
        Recipes.filter { recipe in
            recipe.output.first { $0.id == id } != nil
        }
    }
}

extension String {
    var idFromName: String {
        lowercased()
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: ".", with: "-")
            .replacingOccurrences(of: ":", with: "")
            .replacingOccurrences(of: "™", with: "")
    }
}
