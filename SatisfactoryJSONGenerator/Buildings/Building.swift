import Foundation

struct Building: Item, Encodable {
    let id: String
    let name: String
    let buildingType: BuildingType
    
    init(name: String, buildingType: BuildingType) {
        self.id = name.idFromName
        self.name = name
        self.buildingType = buildingType
    }
}

let Buildings
    = FICSMASBuildings

    + Special
    
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
