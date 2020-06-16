import Foundation

final class Storage {
    static let shared = Storage()
    
    lazy var parts = Bundle.main.parts
    lazy var equipments = Bundle.main.equipments
    lazy var buildings = Bundle.main.buildings
    lazy var vehicles = Bundle.main.vehicles
    lazy var recipes = Bundle.main.recipes
    
    subscript (partId id: UUID) -> Part? {
        parts.first { $0.id == id }
    }
    
    subscript (partName name: String) -> Part? {
        parts.first { $0.name == name }
    }
    
    subscript (equipmentId id: UUID) -> Equipment? {
        equipments.first { $0.id == id }
    }
    
    subscript (buildingId id: UUID) -> Building? {
        buildings.first { $0.id == id }
    }
    
    subscript (vehicleId id: UUID) -> Vehicle? {
        vehicles.first { $0.id == id }
    }
    
    subscript (recipeId id: UUID) -> Recipe? {
        recipes.first { $0.id == id }
    }
    
    subscript (recipesFor id: UUID) -> [Recipe] {
        recipes.filter { $0.output.contains { $0.item.id == id } }
    }
    
    private init() {}
}
