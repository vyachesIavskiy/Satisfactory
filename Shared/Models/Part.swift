import Foundation

enum PartType: String, Hashable, CaseIterable {
    case hubParts = "Hub Parts"
    case ores = "Ores"
    case fuels = "Fuels"
    case aliens = "Aliens"
    case powerSlugs = "Power Slugs"
    case liquids = "Liquids"
    case gases = "Gases"
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
    case ficsmas = "FICSMAS"
}

enum Tier: Int {
    case tier0 = 0
    case tier1 = 1
    case tier2 = 2
    case tier3 = 3
    case tier4 = 4
    case tier5 = 5
    case tier6 = 6
    case tier7 = 7
    case tier8 = 8
}

extension Tier: CustomStringConvertible {
    var description: String {
        switch self {
        case .tier0: return "Building HUB"
        case .tier1: return "Tier 1"
        case .tier2: return "Tier 2"
        case .tier3: return "Tier 3"
        case .tier4: return "Tier 4"
        case .tier5: return "Tier 5"
        case .tier6: return "Tier 6"
        case .tier7: return "Tier 7"
        case .tier8: return "Tier 8"
        }
    }
}

extension Tier: Comparable {
    static func < (lhs: Tier, rhs: Tier) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

struct Part: Item, Hashable, Identifiable {
    let id: String
    let name: String
    let partType: PartType
    let tier: Tier
    let milestone: Int
    let sortingPriority: Int
    let rawResource: Bool
    var isFavorite: Bool
    
    var isLiquid: Bool { partType == .liquids }
    var isGas: Bool { partType == .gases }
}

extension Array where Element == Part {
    func sorted() -> Self {
        sorted {
            $0.sortingPriority < $1.sortingPriority
        }
    }
    
    func sortedByTiers() -> Self {
        sorted { lhs, rhs in
            if lhs.tier < rhs.tier {
                return true
            } else if lhs.tier == rhs.tier {
                if lhs.milestone < rhs.milestone {
                    return true
                } else if lhs.milestone == rhs.milestone {
                    return lhs.sortingPriority < rhs.sortingPriority
                }
            }
            
            return false
        }
    }
}
