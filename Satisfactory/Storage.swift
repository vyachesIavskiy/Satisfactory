import Foundation

final class Storage {
    static let shared = Storage()
    
    lazy var parts = Bundle.main.parts
    lazy var recipes = Bundle.main.recipes
    
    subscript (partId id: UUID) -> Part? {
        parts.first { $0.id == id }
    }
    
//    subscript (equipmentId id: UUID) -> Equipment? {
//        equipments.first { $0.id == id }
//    }
    
    subscript (recipeId id: UUID) -> Recipe? {
        recipes.first { $0.id == id }
    }
    
    subscript (recipeByPartName name: String) -> [Recipe] {
        recipes.filter { $0.output.contains { $0.part.name.lowercased() == name.lowercased() } }
    }
    
    private init() {}
}
