enum Tier: Int, Encodable {
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
