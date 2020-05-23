import Foundation

struct Building: Codable {
    let id = UUID()
    let name: String
    let buildingType: BuildingType
}

let Buildings
    = Special
    + FluidProduction
    + Manufacturers
    + Miners
    + Smelters
    + WorkStations
    + Generators
    + PowerPoles
    + WallPoles
    + ConveyorBelts
    + ConveyorLifts
    + ConveyorSupports
    + PipeSupports
    + Pipelines
    + Sorting
    + Attachments
    + Storage
    + Towers
    + Walkways
    + ConveyourConnections
    + Doors
    + Walls
    + Windows
    + Foundations
    + QuaterPipes
    + Ramps
    + InvertedRamps
    + Hypertubes
    + JumpPads
    + MotorVehicles
    + RailedVehicles
