import Foundation

struct BuildingPersistent: Codable {
    let id: String
    let name: String
    let buildingType: String
}

extension BuildingPersistent: PersistentStoragable {
    static var domain: String { "Buildings" }
    var filename: String { id }
}
