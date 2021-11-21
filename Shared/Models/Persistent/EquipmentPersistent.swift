import Foundation

struct EquipmentPersistent: Codable {
    let id: String
    let name: String
    let slot: String
    let fuel: String?
    let ammo: String?
    let consumes: String?
    var isFavorite: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        slot = try container.decode(String.self, forKey: .slot)
        fuel = try? container.decode(String.self, forKey: .fuel)
        ammo = try? container.decode(String.self, forKey: .ammo)
        consumes = try? container.decode(String.self, forKey: .consumes)
        isFavorite = (try? container.decode(Bool.self, forKey: .isFavorite)) ?? false
    }
    
    init(
        id: String,
        name: String,
        slot: String,
        fuel: String?,
        ammo: String?,
        consumes: String?,
        isFavorite: Bool
    ) {
        self.id = id
        self.name = name
        self.slot = slot
        self.fuel = fuel
        self.ammo = ammo
        self.consumes = consumes
        self.isFavorite = isFavorite
    }
}

extension EquipmentPersistent: PersistentStoragable {
    static var domain: String { "Equipments" }
    var filename: String { id }
}
