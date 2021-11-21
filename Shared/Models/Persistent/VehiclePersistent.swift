import Foundation

struct VehiclePersistent: Codable {
    let id: String
    let name: String
    let fuel: [String]
    var isFavorite: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        fuel = try container.decode([String].self, forKey: .fuel)
        isFavorite = (try? container.decode(Bool.self, forKey: .isFavorite)) ?? false
    }
    
    init(id: String, name: String, fuel: [String], isFavorite: Bool) {
        self.id = id
        self.name = name
        self.fuel = fuel
        self.isFavorite = isFavorite
    }
}

extension VehiclePersistent: PersistentStoragable {
    static var domain: String { "Vehicles" }
    var filename: String { id }
}
