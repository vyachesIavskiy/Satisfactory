import SwiftUI

protocol InMemoryStorageProtocol {
    var parts: [Part] { get set }
    var equipments: [Equipment] { get set }
    var buildings: [Building] { get set }
    var vehicles: [Vehicle] { get set }
    var recipes: [Recipe] { get set }
    
    subscript(itemID id: String) -> Item? { get }
    subscript(partID id: String) -> Part? { get set }
    subscript(equipmentID id: String) -> Equipment? { get set }
    subscript(buildingID id: String) -> Building? { get set }
    subscript(vehicleID id: String) -> Vehicle? { get set }
    subscript(recipeID id: String) -> Recipe? { get set }
    subscript(recipesFor id: String) -> [Recipe] { get }
}

extension InMemoryStorageProtocol {
    subscript(itemID id: String) -> Item? {
        self[partID: id] ??
        self[equipmentID: id] ??
        self[buildingID: id] ??
        self[vehicleID: id]
    }
    
    subscript(partID id: String) -> Part? {
        get {
            parts.first { $0.id == id }
        }
        set {
            guard let newValue = newValue else { return }
            
            guard let index = parts.firstIndex(where: { $0.id == id }) else {
                fatalError("There is no part with id: \(id)")
            }
            parts[index] = newValue
        }
    }
    
    subscript(equipmentID id: String) -> Equipment? {
        get {
            equipments.first { $0.id == id }
        }
        set {
            guard let newValue = newValue else { return }
            
            guard let index = equipments.firstIndex(where: { $0.id == id }) else {
                fatalError("There is no equipment with id: \(id)")
            }
            equipments[index] = newValue
        }
    }
    
    subscript(buildingID id: String) -> Building? {
        get {
            buildings.first { $0.id == id }
        }
        set {
            guard let newValue = newValue else { return }
            
            guard let index = buildings.firstIndex(where: { $0.id == id }) else {
                fatalError("There is no building with id: \(id)")
            }
            buildings[index] = newValue
        }
    }
    
    subscript(vehicleID id: String) -> Vehicle? {
        get {
            vehicles.first { $0.id == id }
        }
        set {
            guard let newValue = newValue else { return }
            
            guard let index = vehicles.firstIndex(where: { $0.id == id }) else {
                fatalError("There is no vehicle with id: \(id)")
            }
            vehicles[index] = newValue
        }
    }
    
    subscript(recipeID id: String) -> Recipe? {
        get {
            recipes.first { $0.id == id }
        }
        set {
            guard let newValue = newValue else { return }
            
            guard let index = recipes.firstIndex(where: { $0.id == id }) else {
                fatalError("There is no recipe with id: \(id)")
            }
            recipes[index] = newValue
        }
    }
    
    subscript(recipesFor id: String) -> [Recipe] {
        recipes.filter { recipe in
            recipe.output.atLeastOneSatisfy { recipePart in
                recipePart.item.id == id
            }
        }
    }
}

struct InMemoryStorage: InMemoryStorageProtocol {
    var parts = [Part]()
    var equipments = [Equipment]()
    var buildings = [Building]()
    var vehicles = [Vehicle]()
    var recipes = [Recipe]()
}

private extension Array {
    func atLeastOneSatisfy(predicate: (Element) throws -> Bool) rethrows -> Bool {
        for element in self {
            if try predicate(element) {
                return true
            }
        }
        
        return false
    }
}
