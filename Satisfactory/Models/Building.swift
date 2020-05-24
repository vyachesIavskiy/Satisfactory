import Foundation

struct Building: Codable {
    let id: UUID
    let name: String
    let buildingType: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id).uuid()
        name = try container.decode(String.self, forKey: .name)
        buildingType = try container.decode(String.self, forKey: .buildingType)
    }
}
