import Foundation

struct RecipePersistent: Codable {
    let id: String
    let name: String
    let input: [RecipePart]
    let output: [RecipePart]
    let machines: [String]
    let duration: Int
    let isDefault: Bool
    let isFavorite: Bool
}

extension RecipePersistent {
    struct RecipePart: Codable {
        let id: String
        let amount: Double
    }
}

extension RecipePersistent: PersistentStoragable {
    static var domain: String { "Recipes" }
    var filename: String { id }
}
