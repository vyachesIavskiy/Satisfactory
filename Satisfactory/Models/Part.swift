import Foundation

struct Parts: Codable {
    let parts: [Part]
}

struct Part: Codable {
    enum ParsingError: Error {
        case cannotParseUUIDFrom(String)
    }
    
    let id: UUID
    let name: String
    let type: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idString = try container.decode(String.self, forKey: .id)
        guard let id = UUID(uuidString: idString) else {
            throw ParsingError.cannotParseUUIDFrom(idString)
        }
        self.id = id
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
    }
}

extension Part: Hashable { }
