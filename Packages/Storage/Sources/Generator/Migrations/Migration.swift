import PersistentModels

struct Migration: Codable {
    var version: Int
    var partIDs: [IDs]
    var equipmentIDs: [IDs]
    var buildingIDs: [IDs]
    var recipeIDs: [IDs]
}

extension Migration {
    struct IDs: Codable {
        var oldID: String
        var newID: String
    }
}
