import Foundation

struct VehiclePersistent: Codable {
    let id: String
    let name: String
    let fuel: [String]
}

extension VehiclePersistent: PersistentStoragable {
    static var domain: String { "Vehicles" }
    var filename: String { id }
}
