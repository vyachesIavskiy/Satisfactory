import Foundation

struct EquipmentNetwork: Codable {
    let id: String
    let name: String
    let slot: String
    let fuel: String?
    let ammo: String?
    let consumes: String?
}
