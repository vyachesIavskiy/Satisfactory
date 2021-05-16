import Foundation

struct Recipe: Codable, Identifiable {
    struct RecipePart: Codable, Hashable, Identifiable {
        let id = UUID()
        let item: Item
        let amount: Double
        
        var productionRecipes: [Recipe] { item.recipes }
        
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
            amount = try container.decode(Double.self, forKey: .amount)
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
        
        func amountPerMinute(with duration: Int) -> Double {
            Double(amount) * (60 / Double(duration))
        }
    }
    
    let id: UUID
    let name: String
    let input: [RecipePart]
    let output: [RecipePart]
    let machine: Building
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
        name = try container.decode(String.self, forKey: .name)
        input = try container.decode([RecipePart].self, forKey: .input)
        output = try container.decode([RecipePart].self, forKey: .output)
        let machineId = try container.decode(String.self, forKey: .machine).uuid()
        if let machine = Storage.shared[buildingId: machineId] {
            self.machine = machine
        } else {
            throw ParsingError.buildingWithIdIsMissing(machineId)
        }
        duration = try container.decode(Int.self, forKey: .duration)
        isDefault = try container.decode(Bool.self, forKey: .isDefault)
    }
}

extension Recipe: Hashable {
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

extension Recipe: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
}
