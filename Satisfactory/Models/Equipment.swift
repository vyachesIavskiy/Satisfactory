import Foundation

struct Equipment: Codable {
    let id: UUID
    let name: String
    let equipmentType: String
    let fuel: UUID?
    let ammo: UUID?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id).uuid()
        name = try container.decode(String.self, forKey: .name)
        equipmentType = try container.decode(String.self, forKey: .equipmentType)
        fuel = try? container.decode(String.self, forKey: .fuel).uuid()
        ammo = try? container.decode(String.self, forKey: .ammo).uuid()
    }
}
