import Foundation

public struct PartLegacy: Decodable {
    public let id: String
    public let name: String
    public let partType: String
    public let tier: Int
    public let milestone: Int
    public let sortingPriority: Int
    public let rawResource: Bool
    
    public init(id: String, name: String, partType: String, tier: Int, milestone: Int, sortingPriority: Int, rawResource: Bool) {
        self.id = id
        self.name = name
        self.partType = partType
        self.tier = tier
        self.milestone = milestone
        self.sortingPriority = sortingPriority
        self.rawResource = rawResource
    }
}
