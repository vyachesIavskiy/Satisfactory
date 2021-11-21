import Foundation

struct PartPersistent: Codable {
    let id: String
    let name: String
    let partType: String
    let tier: Int
    let milestone: Int
    let sortingPriority: Int
    let rawResource: Bool
    var isFavorite: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        partType = try container.decode(String.self, forKey: .partType)
        tier = try container.decode(Int.self, forKey: .tier)
        milestone = try container.decode(Int.self, forKey: .milestone)
        sortingPriority = try container.decode(Int.self, forKey: .sortingPriority)
        rawResource = try container.decode(Bool.self, forKey: .rawResource)
        isFavorite = (try? container.decode(Bool.self, forKey: .isFavorite)) ?? false
    }
    
    init(
        id: String,
        name: String,
        partType: String,
        tier: Int,
        milestone: Int,
        sortingPriority: Int,
        rawResource: Bool,
        isFavorite: Bool
    ) {
        self.id = id
        self.name = name
        self.partType = partType
        self.tier = tier
        self.milestone = milestone
        self.sortingPriority = sortingPriority
        self.rawResource = rawResource
        self.isFavorite = isFavorite
    }
}

extension PartPersistent: PersistentStoragable {
    static var domain: String { "Parts" }
    var filename: String { id }
}
