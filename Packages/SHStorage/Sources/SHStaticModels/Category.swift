import SHModels

extension Category {
    init(fromID id: String) throws {
        self = switch id {
            // Parts
        case Self.ores.id: .ores
        case Self.fluids.id: .fluids
        case Self.matters.id: .matters
        case Self.gases.id: .gases
        case Self.ingots.id: .ingots
        case Self.standardParts.id: .standardParts
        case Self.electronics.id: .electronics
        case Self.compounds.id: .compounds
        case Self.biomass.id: .biomass
        case Self.tools.id: .tools
        case Self.industrialParts.id: .industrialParts
        case Self.communications.id: .communications
        case Self.containers.id: .containers
        case Self.packaging.id: .packaging
        case Self.oilProducts.id: .oilProducts
        case Self.consumables.id: .consumables
        case Self.ammunition.id: .ammunition
        case Self.nuclear.id: .nuclear
        case Self.quantumTechnology.id: .quantumTechnology
        case Self.spaceElevator.id: .spaceElevator
        case Self.alienRemains.id: .alienRemains
        case Self.powerSlugs.id: .powerSlugs
        case Self.powerShards.id: .powerShards
        case Self.ficsmas.id: .ficsmas
        case Self.special.id: .special
            
            // Buildings
        case Self.manufacturers.id: .manufacturers
        case Self.smelters.id: .smelters
        case Self.generators.id: .generators
        case Self.miners.id: .miners
        case Self.fluidExtractors.id: .fluidExtractors
            
        default: throw Error.invalidID(id)
        }
    }
}

private extension Category {
    enum Error: Swift.Error, CustomDebugStringConvertible {
        case invalidID(String)
        
        var debugDescription: String {
            switch self {
            case let .invalidID(id): "Failed to initialized Category with ID '\(id)'"
            }
        }
    }
}

