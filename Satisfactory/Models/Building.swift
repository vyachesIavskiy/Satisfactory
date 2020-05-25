import Foundation

enum BuildingType: String, Codable {
    case special = "Special"
    case fluidProduction = "Fluid Production"
    case manufacturers = "Manufacturers"
    case miners = "Miners"
    case smelters = "Smelters"
    case workstations = "Workstations"
    case generators = "Generators"
    case powerPoles = "Power Poles"
    case wallPoles = "Wall Poles"
    case conveyorBelts = "Conveyor Belts"
    case conveyorLifts = "Conveyor Lifts"
    case conveyorSupports = "Conveyor Supports"
    case pipeSupports = "Pipe Supports"
    case pipelines = "Pipelines"
    case sorting = "Sorting"
    case attachments = "Attachments"
    case storage = "Storage"
    case towers = "Towers"
    case walkways = "Walkways"
    case conveyorConnections = "Conveyor Connections"
    case doors = "Doors"
    case walls = "Walls"
    case windows = "Windows"
    case foundations = "Foundations"
    case quaterPipes = "Quater-Pipes"
    case ramps = "Ramps"
    case invertedRamps = "InvertedRamps"
    case hypertubes = "Hypertubes"
    case jumpPads = "Jump Pads"
    case motorVehicles = "Motor Vehicles"
    case railedVehicles = "Railed Vehicles"
}

struct Building: Codable {
    let id: UUID
    let name: String
    let buildingType: BuildingType
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id).uuid()
        name = try container.decode(String.self, forKey: .name)
        buildingType = try container.decode(BuildingType.self, forKey: .buildingType)
    }
}
