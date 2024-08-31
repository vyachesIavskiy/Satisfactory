import SHPersistentModels

struct Migration: Codable {
    var version: Int
    var partIDs: [IDs]
    var equipmentIDs: [IDs]
    var recipeIDs: [IDs]
    
    init(version: Int, partIDs: [IDs], equipmentIDs: [IDs], recipeIDs: [IDs]) {
        self.version = version
        self.partIDs = partIDs.filter { $0.oldID != $0.newID }
        self.equipmentIDs = equipmentIDs.filter { $0.oldID != $0.newID }
        self.recipeIDs = recipeIDs.filter { $0.oldID != $0.newID }
    }
}

extension Migration {
    struct IDs: Codable {
        var oldID: String
        var newID: String
    }
}
