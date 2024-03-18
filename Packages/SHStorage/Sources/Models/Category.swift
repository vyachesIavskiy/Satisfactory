
public enum Category: Equatable {
    // Parts
    case special
    case ores
    case fuels
    case aliens
    case powerSlugs
    case fluids
    case gases
    case ingots
    case standardParts
    case electronics
    case minerals
    case biomass
    case powerShards
    case industrialParts
    case consumed
    case communications
    case containers
    case oilProducts
    case nuclear
    case spaceElevatorParts
    case ficsmas
    case quantumTechnology
    
    // Equipment
    case head
    case back
    case body
    case hands
    case legs
    
    // Buildings
    case awesomeBonusProgram
    case fluidExtractors
    case manufacturers
    case miners
    case smelters
    case workstations
    case generators
    case powerPoles
    case wallOutlets
    case conveyorBelts
    case conveyorLifts
    case conveyorSupports
    case pipelineSupports
    case pipelines
    case sorting
    case signs
    case attachments
    case lights
    case storage
    case towers
    case walkways
    case catwalks
    case conveyorConnections
    case doors
    case walls
    case windows
    case foundations
    case quaterPipes
    case ramps
    case rampsInverted
    case hypertubes
    case jumpPads
    case vehicleTransport
    case railwayTransport
    case pillars
    case beams
    case roofs
    case frames
    case rampWalls
    case invertedRampWalls
    case tiltedWalls
    
    public var id: String {
        switch self {
        case .special: "category-special"
        case .ores: "category-ores"
        case .fuels: "category-fuels"
        case .aliens: "category-aliens"
        case .powerSlugs: "category-power-slugs"
        case .fluids: "category-fluids"
        case .gases: "category-gases"
        case .ingots: "category-ingots"
        case .standardParts: "category-standard-parts"
        case .electronics: "category-electronics"
        case .minerals: "category-minerals"
        case .biomass: "category-biomass"
        case .powerShards: "category-power-shards"
        case .industrialParts: "category-industrial-parts"
        case .consumed: "category-consumed"
        case .communications: "category-communications"
        case .containers: "category-containers"
        case .oilProducts: "category-oil-products"
        case .nuclear: "category-nuclear"
        case .spaceElevatorParts: "category-space-elevator-parts"
        case .ficsmas: "category-ficsmas"
        case .quantumTechnology: "category-quantum-technology"
        
        // Equipment
        case .head: "category-head"
        case .back: "category-back"
        case .body: "category-body"
        case .hands: "category-hands"
        case .legs: "category-legs"
        
        // Buildings
        case .awesomeBonusProgram: "category-awesome-bonus-program"
        case .fluidExtractors: "category-fluid-extractors"
        case .manufacturers: "category-manufacturers"
        case .miners: "category-miners"
        case .smelters: "category-smelters"
        case .workstations: "category-workstations"
        case .generators: "category-generators"
        case .powerPoles: "category-power-poles"
        case .wallOutlets: "category-wall-outlets"
        case .conveyorBelts: "category-conveyor-belts"
        case .conveyorLifts: "category-conveyor-lifts"
        case .conveyorSupports: "category-conveyor-supports"
        case .pipelineSupports: "category-pipeline-supports"
        case .pipelines: "category-pipelines"
        case .sorting: "category-sorting"
        case .signs: "category-signs"
        case .attachments: "category-attachments"
        case .lights: "category-lights"
        case .storage: "category-storage"
        case .towers: "category-towers"
        case .walkways: "category-walkways"
        case .catwalks: "category-walkways-catwalks"
        case .conveyorConnections: "category-conveyor-connections"
        case .doors: "category-doors"
        case .walls: "category-walls"
        case .windows: "category-windows"
        case .foundations: "category-foundations"
        case .quaterPipes: "category-quater-pipes"
        case .ramps: "category-ramps"
        case .rampsInverted: "category-ramps-inverted"
        case .hypertubes: "category-hypertubes"
        case .jumpPads: "category-jump-pads"
        case .vehicleTransport: "category-vehicle-transport"
        case .railwayTransport: "category-railway-transport"
        case .pillars: "category-pillars"
        case .beams: "category-beams"
        case .roofs: "category-roofs"
        case .frames: "category-frames"
        case .rampWalls: "category-ramp-walls"
        case .invertedRampWalls: "category-inverted-ramp-walls"
        case .tiltedWalls: "category-tilted-walls"
        }
    }
}
