import Foundation

struct Building: Encodable {
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
    + PipelineSupports
    + Pipelines
    + Sorting
    
    + Attachments
    + Lights
    + Storage
    + Towers
    + Walkways
    
    + Foundations
    + QuaterPipes
    + Ramps
    + InvertedRamps
    
    + ConveyourConnections
    + Doors
    + Walls
    + Windows
    
    + Hypertubes
    + JumpPads
    + MotorVehicles
    + RailedVehicles
