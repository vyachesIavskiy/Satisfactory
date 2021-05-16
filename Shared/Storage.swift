import Foundation

final class Storage {
    static let shared = Storage()
    
    lazy var parts = Bundle.main.parts
    lazy var equipments = Bundle.main.equipments
    lazy var buildings = Bundle.main.buildings
    lazy var vehicles = Bundle.main.vehicles
    lazy var recipes = Bundle.main.recipes
    
    subscript (partId id: UUID) -> Part? { parts.first { $0.id == id } }
    subscript (equipmentId id: UUID) -> Equipment? { equipments.first { $0.id == id } }
    subscript (itemId id: UUID) -> Item? { self[partId: id] ?? self[equipmentId: id] }
    subscript (buildingId id: UUID) -> Building? { buildings.first { $0.id == id } }
    subscript (vehicleId id: UUID) -> Vehicle? { vehicles.first { $0.id == id } }
    subscript (recipeId id: UUID) -> Recipe? { recipes.first { $0.id == id } }
    
    subscript (recipesFor id: UUID) -> [Recipe] { recipes.filter { $0.output.contains { $0.item.id == id } } }
    
    subscript (partName name: String) -> Part? { parts.first { $0.name == name } }
    subscript (equipmentName name: String) -> Equipment? { equipments.first { $0.name == name } }
    subscript (itemName name: String) -> Item? { self[partName: name] ?? self[equipmentName: name] }
    subscript (buildingName name: String) -> Building? { buildings.first { $0.name == name } }
    subscript (vehicleName name: String) -> Vehicle? { vehicles.first { $0.name == name } }
    subscript (recipeName name: String) -> Recipe? { recipes.first { $0.name.lowercased().contains(name.lowercased()) } }
    
    static subscript (partId id: UUID) -> Part? { shared[partId: id] }
    static subscript (equipmentId id: UUID) -> Equipment? { shared[equipmentId: id] }
    static subscript (itemId id: UUID) -> Item? { shared[itemId: id] }
    static subscript (buildingId id: UUID) -> Building? { shared[buildingId: id] }
    static subscript (vehicleId id: UUID) -> Vehicle? { shared[vehicleId: id] }
    static subscript (recipeId id: UUID) -> Recipe? { shared[recipeId: id] }
    
    static subscript (recipesFor id: UUID) -> [Recipe] { shared[recipesFor: id] }
    
    static subscript (partName name: String) -> Part? { shared[partName: name] }
    static subscript (equipmentName name: String) -> Equipment? { shared[equipmentName: name] }
    static subscript (itemName name: String) -> Item? { shared[itemName: name] }
    static subscript (buildingName name: String) -> Building? { shared[buildingName: name] }
    static subscript (vehicleName name: String) -> Vehicle? { shared[vehicleName: name] }
    static subscript (recipeName name: String) -> Recipe? { shared[recipeName: name] }
    
    private init() {}
}
