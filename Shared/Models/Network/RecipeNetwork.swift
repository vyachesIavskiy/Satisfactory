import Foundation

struct RecipeNetwork: Codable {
    let id: String
    let name: String
    let input: [RecipePart]
    let output: [RecipePart]
    let machines: [String]
    let duration: Int
    let isDefault: Bool
}

extension RecipeNetwork {
    struct RecipePart: Codable {
        let id: String
        let amount: Double
    }
}
