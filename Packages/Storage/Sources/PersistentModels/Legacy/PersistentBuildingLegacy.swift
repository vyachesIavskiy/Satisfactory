import Foundation

public struct PersistentBuildingLegacy: Decodable {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}
