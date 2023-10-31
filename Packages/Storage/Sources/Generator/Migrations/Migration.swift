import PersistentModels

struct Migration: Codable {
    var version: Version
    var partIDs: [IDs]
    var equipmentIDs: [IDs]
    var buildingIDs: [IDs]
    var recipeIDs: [IDs]
}

extension Migration {
    enum Version: String, Codable {
        case legacyToV2
        // further versions
    }
}

extension Migration {
    struct IDs: Codable {
        var oldID: String
        var newID: String
    }
}
