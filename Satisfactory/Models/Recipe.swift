import Foundation

struct Recipe: Codable, Hashable {
    struct RecipePart: Codable, Hashable {
        let part: Part?
        let equipment: Equipment?
        let amount: Int
        
        enum CodingKeys: String, CodingKey {
            case id
            case amount
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let id = try container.decode(String.self, forKey: .id).uuid()
            part = Storage.shared[partId: id]
            equipment = Storage.shared[equipmentId: id]
            amount = try container.decode(Int.self, forKey: .amount)
        }
        
        static func == (lhs: Recipe.RecipePart, rhs: Recipe.RecipePart) -> Bool {
            if let lid = lhs.part?.id, let rid = rhs.part?.id {
                return lid == rid
            }
            
            if let lid = lhs.equipment?.id, let rid = rhs.equipment?.id {
                return lid == rid
            }
            
            return false
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            if let part = part {
                try container.encode(part.id, forKey: .id)
            }
            if let equipment = equipment {
                try container.encode(equipment.id, forKey: .id)
            }
            try container.encode(amount, forKey: .amount)
        }
        
        func hash(into hasher: inout Hasher) {
            if let id = part?.id {
                hasher.combine(id)
            } else if let id = equipment?.id {
                hasher.combine(id)
            } else {
                hasher.combine(amount)
            }
        }
    }
    
    let id: UUID
    let input: [RecipePart]
    let output: [RecipePart]
    let machine: UUID
    let duration: Int
    let isDefault: Bool
    
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
