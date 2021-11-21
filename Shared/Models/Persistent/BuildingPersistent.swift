import Foundation

struct BuildingPersistent: Codable {
    let id: String
    let name: String
    let buildingType: String
    var isFavorite: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        buildingType = try container.decode(String.self, forKey: .buildingType)
        isFavorite = (try? container.decode(Bool.self, forKey: .isFavorite)) ?? false
    }
    
    init(id: String, name: String, buildingType: String, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.buildingType = buildingType
        self.isFavorite = isFavorite
    }
}

extension BuildingPersistent: PersistentStoragable {
    static var domain: String { "Buildings" }
    var filename: String { id }
}
