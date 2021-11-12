import Foundation

extension Bundle {
    var parts: [PartNetwork] {
        readJSON(from: "parts")
    }
    
    var equipments: [EquipmentNetwork] {
        readJSON(from: "equipment")
    }
    
    var buildings: [BuildingNetwork] {
        readJSON(from: "buildings")
    }
    
    var vehicles: [VehicleNetwork] {
        readJSON(from: "vehicles")
    }
    
    var recipes: [RecipeNetwork] {
        readJSON(from: "recipes")
    }
    
    var version: VersionNetwork {
        readJSON(from: "version")
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
