import Foundation

struct Part: Codable, Resource, CustomStringConvertible {
    let id = UUID()
    let name: String
    let type: PartType
}


let Parts
    = HubParts
    + Ores
    + Fuels
    + Aliens
    + PowerSlugs
    + Liquids
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
