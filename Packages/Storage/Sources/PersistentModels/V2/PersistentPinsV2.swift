import Foundation

public struct PersistentPinsV2: Codable {
    public var partIDs: [String]
    public var equipmentIDs: [String]
    public var recipeIDs: [String]
    
    public init(partIDs: [String] = [], equipmentIDs: [String] = [], recipeIDs: [String] = []) {
        self.partIDs = partIDs
        self.equipmentIDs = equipmentIDs
        self.recipeIDs = recipeIDs
    }
}
