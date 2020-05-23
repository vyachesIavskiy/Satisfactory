import Foundation

extension Bundle {
    var parts: [Part] {
        guard let url = url(forResource: "parts", withExtension: "json") else { return [] }
        do {
            let data = try Data(contentsOf: url)
            let parts = try JSONDecoder().decode(Parts.self, from: data)
            return parts.parts
        } catch {
            print(error)
            return []
        }
    }
    
    var recipes: [Recipe] {
        guard let url = url(forResource: "recipes", withExtension: "json") else { return [] }
        do {
            let data = try Data(contentsOf: url)
            let recipes = try JSONDecoder().decode(Recipes.self, from: data)
            return recipes.recipes
        } catch {
            print(error)
            return []
        }
    }
}
