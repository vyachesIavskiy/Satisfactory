import Foundation

struct EquipmentPersistent: Codable {
    let id: String
    let name: String
    let slot: String
    let fuel: String?
    let ammo: String?
    let consumes: String?
}

extension EquipmentPersistent: PersistentStoragable {
    static var domain: String { "Equipments" }
    var filename: String { id }
}
