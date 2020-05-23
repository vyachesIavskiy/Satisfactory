import Foundation

struct Building: Codable {
    let id = UUID()
    let name: String
    let buildingType: BuildingType
}

// MARK: - Special
let hub = Building(name: "The HUB", buildingType: .special)
let mam = Building(name: "M.A.M.", buildingType: .special)
let spaceElevator = Building(name: "Space Elevator", buildingType: .special)
let awesomeSink = Building(name: "AWESOME Sink", buildingType: .special)
let awesomeShop = Building(name: "AWESOME Shop", buildingType: .special)

// MARK: - Fluid Production
let waterExctractor = Building(name: "Water Exctracor", buildingType: .fluidProduction)
let oilExctractor = Building(name: "Oil Exctractor", buildingType: .fluidProduction)
let refinery = Building(name: "Refinery", buildingType: .fluidProduction)

// MARK: - Manufacturers
let constructor = Building(name: "Constructor", buildingType: .manufacturers)
let assembler = Building(name: "Assembler", buildingType: .manufacturers)
let manufacturer = Building(name: "Manufacturer", buildingType: .manufacturers)

// MARK: - Miners
let minerMK1 = Building(name: "Miner MK.1", buildingType: .miners)
let minerMK2 = Building(name: "Miner MK.2", buildingType: .miners)

// MARK: - Smelters
let smelter = Building(name: "Smelter", buildingType: .smelters)
let foundry = Building(name: "Foundry", buildingType: .smelters)

// MARK: - Workstations
let craftBench = Building(name: "Craft Bench", buildingType: .workstations)
let equipmentWorkshop = Building(name: "Equipment Workshop", buildingType: .workstations)

// MARK: - Generators
let biomassGenerator = Building(name: "Biomass Generator", buildingType: .generators)
let coalGenerator = Building(name: "Coal Generator", buildingType: .generators)
let fuelGenerator = Building(name: "Fuel Generator", buildingType: .generators)

// MARK: - Power Poles
let powerPole = Building(name: "Power Pole", buildingType: .powerPoles)
let powerLine = Building(name: "Power Line", buildingType: .powerPoles)

// MARK: - Power Walls
let wallPowerPole = Building(name: "Wall Power Pole", buildingType: .wallPoles)
let doublesidedWallPower = Building(name: "Double-sided Wall Power", buildingType: .wallPoles)

// MARK: - Conveyor Belts
let conveyorBelt = Building(name: "Conveyor Belt", buildingType: .conveyorBelts)
let conveyorBeltMK2 = Building(name: "Conveyor Belt MK.2", buildingType: .conveyorBelts)
let conveyorBeltMK3 = Building(name: "Conveyor Belt MK.3", buildingType: .conveyorBelts)
let conveyorBeltMK4 = Building(name: "Conveyor Belt MK.4", buildingType: .conveyorBelts)

// MARK: - Conveyor Lifts
let conveyorLift = Building(name: "Conveyor Lift", buildingType: .conveyorLifts)
let conveyorLiftMK2 = Building(name: "Conveyor Lift MK.2", buildingType: .conveyorLifts)
let conveyorLiftMK3 = Building(name: "Conveyor Lift MK.3", buildingType: .conveyorLifts)
let conveyorLiftMK4 = Building(name: "Conveyor Lift MK.4", buildingType: .conveyorLifts)

// MARK: - Conveyor Supports
let conveyorPole = Building(name: "Conveyor Pole", buildingType: .conveyorSupports)
let conveyorStackablePole = Building(name: "Conveyor Stackable Pole", buildingType: .conveyorSupports)
let conveyorWallMount = Building(name: "Conveyor Wall Mount", buildingType: .conveyorSupports)

// MARK: - Pipe Supports
let pipelineSupport = Building(name: "Pipeline Support", buildingType: .pipeSupports)
let stackablePipeline = Building(name: "Stackable Pipeline", buildingType: .pipeSupports)
let pipelineWallSupport = Building(name: "Pipeline Wall Support", buildingType: .pipeSupports)
let pipelineWallHole = Building(name: "Pipeline Wall Hole", buildingType: .pipeSupports)

// MARK: - Pipelines
let pipeline = Building(name: "Pipeline", buildingType: .pipelines)
let pipelineJunkctionCross = Building(name: "Pipeline Junktion Cross", buildingType: .pipelines)
let pipelinePump = Building(name: "Pipeline Pump", buildingType: .pipelines)

// MARK: - Sorting
let coveyorSplitter = Building(name: "Conveyor Splitter", buildingType: .sorting)
let conveyorMerger = Building(name: "Conveyor Merger", buildingType: .sorting)

// MARK: - Storage
let personalStorageBox = Building(name: "Personal Storage Box", buildingType: .storage)
let storageContainer = Building(name: "Storage Container", buildingType: .storage)
let industrialStorage = Building(name: "Industrial Storage", buildingType: .storage)
let industrialFluidBuffer = Building(name: "Industrial Storage Buffer", buildingType: .storage)
let industrialFluidBufferMK2 = Building(name: "Industrial Storage Buffer", buildingType: .storage)

// MARK: - Towers
let lookoutTower = Building(name: "Lookout Tower", buildingType: .towers)

// MARK: - Walkways
let walkwayStraight = Building(name: "Walkway Straight", buildingType: .walkways)
let walkwayTurn = Building(name: "Walkway Turn", buildingType: .walkways)
let walkwayTCrossing = Building(name: "Walkway T-Crossing", buildingType: .walkways)
let walkwayCrossing = Building(name: "Walkway Crossing", buildingType: .walkways)
let walkwayRamp = Building(name: "Walkway Ramp", buildingType: .walkways)

// MARK: - Conveyor Connections
let wallConveyor1 = Building(name: "Wall Conveyor x1", buildingType: .conveyorConnections)
let wallConveyor2 = Building(name: "Wall Conveyor x2", buildingType: .conveyorConnections)
let wallConveyor3 = Building(name: "Wall Conveyor x3", buildingType: .conveyorConnections)

// MARK: - Walls
let wall8x4 = Building(name: "Wall 8m x 4m", buildingType: .walls)
let wall8x4Gray = Building(name: "Wall 8m x 4m", buildingType: .walls)
let wallWindow8x41 = Building(name: "Wall Window 8m x 4m 01", buildingType: .walls)
let wallWindow8x42 = Building(name: "Wall Window 8m x 4m 02", buildingType: .walls)
let wallWindow8x43 = Building(name: "Wall Window 8m x 4m 03", buildingType: .walls)
let wallWindow8x44 = Building(name: "Wall Window 8m x 4m 04", buildingType: .walls)
let fence1 = Building(name: "Fence 1", buildingType: .walls)

// MARK: - Foundations
let foundation8x1 = Building(name: "Foundation 8m x 1m", buildingType: .foundations)
let foundation8x2 = Building(name: "Foundation 8m x 2m", buildingType: .foundations)
let foundation8x4 = Building(name: "Foundation 8m x 4m", buildingType: .foundations)
let pillarBase = Building(name: "Pillar Base", buildingType: .foundations)
let pillarMiddle = Building(name: "Pillar Middle", buildingType: .foundations)
let pillarTop = Building(name: "Pillar Top", buildingType: .foundations)
let foundationFrame = Building(name: "Foundation Frame", buildingType: .foundations)
let foundationGlass = Building(name: "Foundation Glass", buildingType: .foundations)

// MARK: - Ramps
let ramp8x1 = Building(name: "Ramp 8m x 1m", buildingType: .ramps)
let ramp8x2 = Building(name: "Ramp 8m x 2m", buildingType: .ramps)
let ramp8x4 = Building(name: "Ramp 8m x 4m", buildingType: .ramps)
let cornerRampDown8x1 = Building(name: "Corner Ramp Down 8m x 1m", buildingType: .ramps)
let cornerRampUp8x1 = Building(name: "Corner Ramp Up 8m x 1m", buildingType: .ramps)
let cornerRampDown8x2 = Building(name: "Corner Ramp Down 8m x 2m", buildingType: .ramps)
let cornerRampUp8x2 = Building(name: "Corner Ramp Up 8m x 2m", buildingType: .ramps)
let cornerRampDown8x4 = Building(name: "Corner Ramp Down 8m x 4m", buildingType: .ramps)
let cornerRampUp8x4 = Building(name: "Corner Ramp Up 8m x 4m", buildingType: .ramps)
let rampInverted8x4 = Building(name: "Ramp Inverted 8m x 4m", buildingType: .ramps)
let rampDouble8x8 = Building(name: "Ramp Double 8m x 8m", buildingType: .ramps)

// MARK: - Hypertubes
let hyperTube = Building(name: "Hyper Tube", buildingType: .hypertubes)
let hyperTubeEntrance = Building(name: "Hyper Tube Entrance", buildingType: .hypertubes)
let hyperTubeSupport = Building(name: "Hyper Tube Support", buildingType: .hypertubes)

// MARK: - Jump Pads
let jumpPad = Building(name: "Jump Pad", buildingType: .jumpPads)
let tiltedJumpPad = Building(name: "Tilted Jump Pad", buildingType: .jumpPads)
let ujellyLandingPad = Building(name: "U-jelly Landing Pad", buildingType: .jumpPads)

// MARK: - Motor Vehicles
let truckStation = Building(name: "Truck Station", buildingType: .motorVehicles)

let buildings = [
    hub,
    mam,
    spaceElevator,
    awesomeSink,
    awesomeShop,
    
    waterExctractor,
    oilExctractor,
    refinery,
    
    constructor,
    assembler,
    manufacturer,
    
    minerMK1,
    minerMK2,
    
    smelter,
    foundry,
    
    craftBench,
    equipmentWorkshop,
    
    biomassGenerator,
    coalGenerator,
    fuelGenerator,
    
    powerPole,
    powerLine,
    
    wallPowerPole,
    doublesidedWallPower,
    
    conveyorBelt,
    conveyorBeltMK2,
    conveyorBeltMK3,
    conveyorBeltMK4,
    
    conveyorLift,
    conveyorLiftMK2,
    conveyorLiftMK3,
    conveyorLiftMK4,
    
    conveyorPole,
    conveyorStackablePole,
    conveyorWallMount,
    
    pipelineSupport,
    stackablePipeline,
    pipelineWallSupport,
    pipelineWallHole,
    
    pipeline,
    pipelineJunkctionCross,
    pipelinePump,
    
    coveyorSplitter,
    conveyorMerger,
    
    personalStorageBox,
    storageContainer,
    industrialStorage,
    industrialFluidBuffer,
    industrialFluidBufferMK2,
    
    lookoutTower,
    
    walkwayStraight,
    walkwayTurn,
    walkwayTCrossing,
    walkwayCrossing,
    walkwayRamp,
    
    wall8x4,
    wall8x4Gray,
    wallWindow8x41,
    wallWindow8x42,
    wallWindow8x43,
    wallWindow8x44,
    fence1,
    
    foundation8x1,
    foundation8x2,
    foundation8x4,
    pillarBase,
    pillarMiddle,
    pillarTop,
    foundationFrame,
    foundationGlass,
    
    ramp8x1,
    ramp8x2,
    ramp8x4,
    cornerRampDown8x1,
    cornerRampUp8x1,
    cornerRampDown8x2,
    cornerRampUp8x2,
    cornerRampDown8x4,
    cornerRampUp8x4,
    rampInverted8x4,
    rampDouble8x8,
    
    wallConveyor1,
    wallConveyor2,
    wallConveyor3,
    
    hyperTube,
    hyperTubeEntrance,
    hyperTubeSupport,
    
    jumpPad,
    tiltedJumpPad,
    ujellyLandingPad,
    
    truckStation
]
