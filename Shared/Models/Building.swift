import Foundation

enum BuildingType: String, Hashable, CaseIterable {
    case ficsmas = "FICSMAS"
    case special = "Special"
    case fluidExtractors = "Fluid Extractors"
    case manufacturers = "Manufacturers"
    case miners = "Miners"
    case smelters = "Smelters"
    case workstations = "Workstations"
    case generators = "Generators"
    case powerPoles = "Power Poles"
    case wallOutlets = "Wall Outlets"
    case conveyorBelts = "Conveyor Belts"
    case conveyorLifts = "Conveyor Lifts"
    case conveyorSupports = "Conveyor Supports"
    case pipelineSupports = "Pipeline Supports"
    case pipelines = "Pipelines"
    case sorting = "Sorting"
    case attachments = "Attachments"
    case lights = "Lights"
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
    case rampsInverted = "Ramps Inverted"
    case hypertubes = "Hypertubes"
    case jumpPads = "Jump Pads"
    case motorVehicles = "Motor Vehicles"
    case railedVehicles = "Railed Vehicles"
}

struct Building: Item, Hashable {
    let id: String
    let name: String
    let buildingType: BuildingType
    var isPinned: Bool
    
    var imageName: String { "building-\(id)" }
}
