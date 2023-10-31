import Foundation

struct Part: Encodable, Item, CustomStringConvertible {
    let id: String
    let name: String
    let partType: PartType
    let tier: Tier
    let milestone: Int
    let sortingPriority: Int
    let rawResource: Bool
    
    init(
        name: String,
        partType: PartType,
        tier: Tier,
        milestone: Int,
        sortingPriority: Int,
        rawResource: Bool = false
    ) {
        self.id = name.idFromName
        self.name = name
        self.partType = partType
        self.tier = tier
        self.milestone = milestone
        self.sortingPriority = sortingPriority
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
    + FICSMASParts
