import Foundation

struct Recipe: Codable, Hashable, Identifiable {
    struct RecipePart: Codable, Hashable, Identifiable {
        let id = UUID()
        let item: Item
        let amount: Int
        
        var productionRecipes: [Recipe] {
            item.recipes
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case amount
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let id = try container.decode(String.self, forKey: .id).uuid()
            if let part = Storage.shared[partId: id] {
                item = part
            } else if let equipment = Storage.shared[equipmentId: id] {
                item = equipment
            } else {
                throw ParsingError.itemWithIdIsMissing(id)
            }
            amount = try container.decode(Int.self, forKey: .amount)
        }
        
        static func == (lhs: Recipe.RecipePart, rhs: Recipe.RecipePart) -> Bool {
            lhs.item.id == rhs.item.id
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(item.id, forKey: .id)
            try container.encode(amount, forKey: .amount)
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(item.id)
        }
    }
    
    let id: UUID
    let input: [RecipePart]
    let output: [RecipePart]
    let machine: UUID
    let duration: Int
    let isDefault: Bool
    
    var allInputItems: [Item] {
        input.reduce(into: []) { result, part in
            guard !part.item.recipes.isEmpty else { return }
            result += part.item.recipes.reduce([]) { $0 + $1.allInputItems }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id).uuid()
        input = try container.decode([RecipePart].self, forKey: .input)
        output = try container.decode([RecipePart].self, forKey: .output)
        machine = try container.decode(String.self, forKey: .machine).uuid()
        duration = try container.decode(Int.self, forKey: .duration)
        isDefault = try container.decode(Bool.self, forKey: .isDefault)
    }
}
