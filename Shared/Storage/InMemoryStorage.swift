import SwiftUI

protocol InMemoryStorageProtocol {
    var parts: [Part] { get set }
    var equipments: [Equipment] { get set }
    var buildings: [Building] { get set }
    var recipes: [Recipe] { get set }
    var productionChains: [ProductionChain] { get set }
    var factories: [Factory] { get set }
    
    subscript(itemID id: String) -> Item? { get set }
    subscript(partID id: String) -> Part? { get set }
    subscript(equipmentID id: String) -> Equipment? { get set }
    subscript(buildingID id: String) -> Building? { get set }
    subscript(recipeID id: String) -> Recipe? { get set }
    subscript(recipesFor id: String) -> [Recipe] { get }
    subscript(productionChainID id: String) -> ProductionChain? { get set }
    
    func productionChains(where predicate: (ProductionChain) -> Bool) -> [ProductionChain]
}

extension InMemoryStorageProtocol {
    subscript(itemID id: String) -> Item? {
        get {
            let result: Item? = self[partID: id] ??
            self[equipmentID: id] ??
            self[buildingID: id]
            
//            assert(result != nil, "Item '\(id)' is not found")
            
            return result
        }
        set {
            guard let newValue = newValue else { return }
            
            if let index = parts.firstIndex(of: id),
               let part = newValue as? Part {
                parts[index] = part
            } else if let index = equipments.firstIndex(of: id),
                      let equipment = newValue as? Equipment {
                equipments[index] = equipment
            } else if let index = buildings.firstIndex(of: id),
                      let building = newValue as? Building {
                buildings[index] = building
            } else {
                fatalError("There is no item with id: \(id)")
            }
        }
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
    
    subscript(productionChainID id: String) -> ProductionChain? {
        get {
            productionChains.first { $0.id == id }
        }
        set {
            if let newValue = newValue {
                if let index = productionChains.firstIndex(where: { $0.id == id }) {
                    productionChains[index] = newValue
                } else {
                    productionChains.append(newValue)
                }
            } else {
                if let index = productionChains.firstIndex(where: { $0.id == id }) {
                    productionChains.remove(at: index)
                }
            }
        }
    }
    
    func productionChains(where predicate: (ProductionChain) -> Bool) -> [ProductionChain] {
        productionChains.filter(predicate)
    }
    
    subscript(factoryID id: UUID) -> Factory? {
        get {
            factories.first { $0.id == id }
        }
        set {
            if let newValue {
                if let index = factories.firstIndex(where: { $0.id == id }) {
                    factories[index] = newValue
                } else {
                    factories.append(newValue)
                }
            } else if let index = factories.firstIndex(where: { $0.id == id }) {
                factories.remove(at: index)
            }
        }
    }
}

struct InMemoryStorage: InMemoryStorageProtocol {
    var parts = [Part]()
    var equipments = [Equipment]()
    var buildings = [Building]()
    var recipes = [Recipe]()
    var productionChains = [ProductionChain]()
    var factories = [Factory]()
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
