import Foundation

struct PartPersistent: Codable {
    let id: String
    let name: String
    let partType: String
    let tier: Int
    let milestone: Int
    let sortingPriority: Int
    let rawResource: Bool
}

extension PartPersistent: PersistentStoragable {
    static var domain: String { "Parts" }
    var filename: String { id }
}
