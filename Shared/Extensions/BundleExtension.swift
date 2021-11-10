import Foundation

extension Bundle {
    var parts: [Part] {
        let parts: [PartNetwork] = readJSON(from: "parts")
        return parts.map { part in
            Part(
                id: part.id,
                name: part.name,
                partType: .init(rawValue: part.partType)!,
                tier: .init(rawValue: part.tier)!,
                milestone: part.milestone,
                sortingPriority: part.sortingPriority,
                rawResource: part.rawResource
            )
        }
    }
    
    var equipments: [Equipment] {
        let equipments: [EquipmentNetwork] = readJSON(from: "equipment")
        return equipments.map { equipment in
            Equipment(
                id: equipment.id,
                name: equipment.name,
                equipmentType: .init(rawValue: equipment.equipmentType)!,
                fuel: equipment.fuel,
                ammo: equipment.ammo
            )
        }
    }
    
    var buildings: [Building] {
        let buildings: [BuildingNetwork] = readJSON(from: "buildings")
        return buildings.map { building in
            Building(
                id: building.id,
                name: building.name,
                buildingType: .init(rawValue: building.buildingType)!
            )
        }
    }
    
    var vehicles: [Vehicle] {
        let vehicles: [VehicleNetwork] = readJSON(from: "vehicles")
        return vehicles.map { vehicle in
            Vehicle(id: vehicle.id, name: vehicle.name)
        }
    }
    
    var recipes: [Recipe] {
        let recipes: [RecipeNetwork] = readJSON(from: "recipes")
        return recipes.map { recipe in
            Recipe(
                id: recipe.id,
                name: recipe.name,
                input: recipe.input.map { input in
                    Recipe.RecipePartOld(item: Storage[itemId: input.id]!, amount: input.amount)
                },
                output: recipe.output.map { output in
                    Recipe.RecipePartOld(item: Storage[itemId: output.id]!, amount: output.amount)
                },
                machines: recipe.machines.map { machine in
                    Storage[buildingId: machine]!
                },
                duration: recipe.duration,
                isDefault: recipe.isDefault
            )
        }
    }
    
    private func readJSON<Model: Codable>(from file: String) -> Model {
        guard let url = url(forResource: file, withExtension: "json") else {
            fatalError("Could not find \(file).json")
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Model.self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
