import Foundation

public struct BuildingLegacy: Decodable {
    public let id: String
    public let name: String
    public let buildingType: String
    
    public init(id: String, name: String, buildingType: String) {
        self.id = id
        self.name = name
        self.buildingType = buildingType
    }
}
