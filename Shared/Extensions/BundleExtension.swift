import Foundation

extension Bundle {
    var parts: [Part] { readJSON(from: "parts") }
    var equipments: [Equipment] { readJSON(from: "equipment") }
    var buildings: [Building] { readJSON(from: "buildings") }
    var vehicles: [Vehicle] { readJSON(from: "vehicles") }
    var recipes: [Recipe] { readJSON(from: "recipes") }
    
    private func readJSON<Model: Codable>(from file: String) -> Model {
        guard let url = url(forResource: file, withExtension: "json") else {
            fatalError("Could not find \(file).json")
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Model.self, from: data)
        } catch let error as ParsingError {
            fatalError(error.description)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
