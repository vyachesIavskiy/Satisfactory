import Foundation

struct Recipes: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Hashable {
    enum ParsingError: Error {
        case cannotParseUUIDFrom(String)
        case partWithIdIsNotPresent(String)
    }
    
    struct RecipePart: Codable, Hashable {
        let part: Part
        let amount: Double
        
        enum CodingKeys: String, CodingKey {
            case id
            case amount
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let idString = try container.decode(String.self, forKey: .id)
            guard let id = UUID(uuidString: idString) else {
                throw ParsingError.cannotParseUUIDFrom(idString)
            }
            
            guard let part = Storage.shared[partId: id] else {
                throw ParsingError.partWithIdIsNotPresent(idString)
            }
            
            self.part = part
            amount = try container.decode(Double.self, forKey: .amount)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(part.id, forKey: .id)
            try container.encode(amount, forKey: .amount)
        }
    }
    
    let id: UUID
    let input: [RecipePart]
    let output: [RecipePart]
    let machine: String
    let isDefault: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idString = try container.decode(String.self, forKey: .id)
        guard let id = UUID(uuidString: idString) else {
            throw ParsingError.cannotParseUUIDFrom(idString)
        }
        
        self.id = id
        input = try container.decode([RecipePart].self, forKey: .input)
        output = try container.decode([RecipePart].self, forKey: .output)
        machine = try container.decode(String.self, forKey: .machine)
        isDefault = try container.decode(Bool.self, forKey: .isDefault)
    }
}

extension Recipe: CustomStringConvertible {
    var description: String {
        """
        \(output.reduce("") { "\($0)\n\($1.part.name): \($1.amount)" } )
        -----------------------------------
        \(input.reduce("") { "\($0)\n\($1.part.name): \($1.amount)" } )
        """
    }
}
