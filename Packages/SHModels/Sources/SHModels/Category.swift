import Foundation

public enum Category: Int, Equatable, Sendable {
    // Parts
    case ores
    case fluids
    case matters
    case gases
    case ingots
    case standardParts
    case electronics
    case compounds
    case biomass
    case tools
    case industrialParts
    case communications
    case containers
    case packaging
    case oilProducts
    case consumables
    case ammunition
    case nuclear
    case quantumTechnology
    case spaceElevator
    case alienRemains
    case powerSlugs
    case powerShards
    case ficsmas
    case special
    
    // Buildings
    case manufacturers
    case smelters
    case generators
    case miners
    case fluidExtractors
    
    public var id: String {
        switch self {
        case .ores: "category-ores"
        case .fluids: "category-fluids"
        case .matters: "category-matters"
        case .gases: "category-gases"
        case .ingots: "category-ingots"
        case .standardParts: "category-standard-parts"
        case .electronics: "category-electronics"
        case .compounds: "category-compounds"
        case .biomass: "category-biomass"
        case .tools: "category-tools"
        case .industrialParts: "category-industrial-parts"
        case .communications: "category-communications"
        case .containers: "category-containers"
        case .packaging: "category-packaging"
        case .oilProducts: "category-oil-products"
        case .consumables: "category-consumables"
        case .ammunition: "category-ammunition"
        case .nuclear: "category-nuclear"
        case .quantumTechnology: "category-quantum-technology"
        case .spaceElevator: "category-space-elevator"
        case .alienRemains: "category-alien-remains"
        case .powerSlugs: "category-power-slugs"
        case .powerShards: "category-power-shards"
        case .ficsmas: "category-ficsmas"
        case .special: "category-special"
            
        case .fluidExtractors: "category-fluid-extractors"
        case .manufacturers: "category-manufacturers"
        case .miners: "category-miners"
        case .smelters: "category-smelters"
        case .generators: "category-generators"
        }
    }
    
    public var localizedName: String {
        NSLocalizedString(id, tableName: "Categories", bundle: .module, comment: "")
    }
}

extension Category: Comparable {
    public static func < (lhs: Category, rhs: Category) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
