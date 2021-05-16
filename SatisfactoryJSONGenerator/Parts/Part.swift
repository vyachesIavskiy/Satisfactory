import Foundation

struct Part: Encodable, Resource, CustomStringConvertible {
    let id = UUID()
    let name: String
    let partType: PartType
    let rawResource: Bool
    
    init(name: String, partType: PartType, rawResource: Bool = false) {
        self.name = name
        self.partType = partType
        self.rawResource = rawResource
    }
}

let Parts
    = HubParts
    + Ores
    + Fuels
    + Aliens
    + PowerSlugs
    + Liquids
    + Gases
    + Ingots
    + StandartParts
    + Electronics
    + Minerals
    + Biomasses
    + PowerShards
    + IndustrialParts
    + Consumed
    + Communications
    + Containers
    + OilProducts
    + Nuclear
    + SpaceElevatorParts
