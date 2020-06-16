import Foundation

enum PartType: String, Codable, Hashable, CaseIterable {
    case hubParts = "Hub Parts"
    case ores = "Ores"
    case fuels = "Fuels"
    case aliens = "Aliens"
    case powerSlugs = "Power Slugs"
    case liquids = "Liquids"
    case ingots = "Ingots"
    case standartParts = "Standart Parts"
    case electronics = "Electronics"
    case minerals = "Minerals"
    case biomass = "Biomass"
    case powerShards = "Power Shards"
    case industrialParts = "Industrial Parts"
    case consumed = "Consumed"
    case communications = "Communications"
    case containers = "Containers"
    case oilProducts = "Oil Products"
    case nuclear = "Nuclear"
    case spaceElevatorParts = "Space Elevator Parts"
}

struct Part: Item, Codable, Hashable, Identifiable {
    let id: UUID
    let name: String
    let partType: PartType
    
    var isLiquid: Bool { return partType == .liquids }
    
    var recipes: [Recipe] { Storage.shared[recipesFor: id] }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id).uuid()
        name = try container.decode(String.self, forKey: .name)
        partType = try container.decode(PartType.self, forKey: .partType)
    }
}
