import Foundation

protocol Resource {
    var id: UUID { get }
    var name: String { get }
}

extension CustomStringConvertible where Self: Resource {
    var description: String { name }
}

extension Resource {
    var recipes: [Recipe] {
        Recipes.filter { recipe in
            recipe.output.first { $0.id == id } != nil
        }
    }
}
