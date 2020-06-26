// MARK: - Standart Parts
let reinforcedIronPlateRecipe = Recipe(
    name: "Reinforced Iron Plate",
    input: [
        .init(ironPlate, amount: 6),
        .init(screw, amount: 12)
    ],
    output: [
        .init(reinforcedIronPlate, amount: 1)
    ],
    machine: assembler,
    duration: 12
)

let reinforcedIronPlateRecipe1 = Recipe(
    name: "Alternate: Adhered Iron Plate",
    input: [
        .init(ironPlate, amount: 3),
        .init(rubber, amount: 1)
    ],
    output: [
        .init(reinforcedIronPlate, amount: 1)
    ],
    machine: assembler,
    duration: 16,
    isDefault: false
)

let reinforcedIronPlateRecipe2 = Recipe(
    name: "Alternate: Bolted Iron Plate",
    input: [
        .init(ironPlate, amount: 18),
        .init(screw, amount: 50)
    ],
    output: [
        .init(reinforcedIronPlate, amount: 3)
    ],
    machine: assembler,
    duration: 12,
    isDefault: false
)

let reinforcedIronPlateRecipe3 = Recipe(
    name: "Alternate: Stitched Iron Plate",
    input: [
        .init(ironPlate, amount: 10),
        .init(wire, amount: 20)
    ],
    output: [
        .init(reinforcedIronPlate, amount: 3)
    ],
    machine: assembler,
    duration: 32,
    isDefault: false
)

let modularFrameRecipe = Recipe(
    name: "Modular Frame",
    input: [
        .init(reinforcedIronPlate, amount: 3),
        .init(ironRod, amount: 12)
    ],
    output: [
        .init(modularFrame, amount: 2)
    ],
    machine: assembler,
    duration: 60
)

let modularFrameRecipe1 = Recipe(
    name: "Alternate: Bolted Frame",
    input: [
        .init(reinforcedIronPlate, amount: 3),
        .init(screw, amount: 56)
    ],
    output: [
        .init(modularFrame, amount: 2)
    ],
    machine: assembler,
    duration: 24,
    isDefault: false
)

let modularFrameRecipe2 = Recipe(
    name: "Alternate: Steeled Frame",
    input: [
        .init(reinforcedIronPlate, amount: 2),
        .init(steelPipe, amount: 10)
    ],
    output: [
        .init(modularFrame, amount: 3)
    ],
    machine: assembler,
    duration: 60,
    isDefault: false
)

let encasedIndustrialBeamRecipe = Recipe(
    name: "Encased Industrial Beam",
    input: [
        .init(steelBeam, amount: 4),
        .init(concrete, amount: 5)
    ],
    output: [
        .init(encasedIndustrialBeam, amount: 1)
    ],
    machine: assembler,
    duration: 10
)

let encasedIndustrialBeamRecipe1 = Recipe(
    name: "Alternate: Encased Industrial Pipe",
    input: [
        .init(steelPipe, amount: 7),
        .init(concrete, amount: 5)
    ],
    output: [
        .init(encasedIndustrialBeam, amount: 1)
    ],
    machine: assembler,
    duration: 15,
    isDefault: false
)

let alcladAluminumSheetRecipe = Recipe(
    name: "Alclad Aluminum Sheet",
    input: [
        .init(aluminumIngot, amount: 8),
        .init(copperIngot, amount: 3)
    ],
    output: [
        .init(alcladAluminumSheet, amount: 4)
    ],
    machine: assembler,
    duration: 8
)

let ironPlateRecipe1 = Recipe(
    name: "Alternate: Coated Iron Plate",
    input: [
        .init(ironIngot, amount: 10),
        .init(plastic, amount: 2)
    ],
    output: [
        .init(ironPlate, amount: 15)
    ],
    machine: assembler,
    duration: 12,
    isDefault: false
)

let ironPlateRecipe2 = Recipe(
    name: "Alternate: Steel Coated Plate",
    input: [
        .init(steelIngot, amount: 3),
        .init(plastic, amount: 2)
    ],
    output: [
        .init(ironPlate, amount: 18)
    ],
    machine: assembler,
    duration: 24,
    isDefault: false
)

// MARK: - Industrial Parts
let rotorRecipe = Recipe(
    name: "Rotor",
    input: [
        .init(ironRod, amount: 5),
        .init(screw, amount: 25)
    ],
    output: [
        .init(rotor, amount: 1)
    ],
    machine: assembler,
    duration: 15
)

let rotorRecipe1 = Recipe(
    name: "Alternate: Copper Rotor",
    input: [
        .init(copperSheet, amount: 6),
        .init(screw, amount: 52)
    ],
    output: [
        .init(rotor, amount: 3)
    ],
    machine: assembler,
    duration: 16,
    isDefault: false
)

let rotorRecipe2 = Recipe(
    name: "Alternate: Steel Rotor",
    input: [
        .init(steelPipe, amount: 2),
        .init(wire, amount: 6)
    ],
    output: [
        .init(rotor, amount: 1)
    ],
    machine: assembler,
    duration: 12,
    isDefault: false
)

let statorRecipe = Recipe(
    name: "Stator",
    input: [
        .init(steelPipe, amount: 3),
        .init(wire, amount: 8)
    ],
    output: [
        .init(stator, amount: 1)
    ],
    machine: assembler,
    duration: 12
)

let statorRecipe1 = Recipe(
    name: "Alternate: Quickwire Stator",
    input: [
        .init(steelPipe, amount: 4),
        .init(quickwire, amount: 15)
    ],
    output: [
        .init(stator, amount: 2)
    ],
    machine: assembler,
    duration: 15,
    isDefault: false
)

let motorRecipe = Recipe(
    name: "Motor",
    input: [
        .init(rotor, amount: 2),
        .init(stator, amount: 2)
    ],
    output: [
        .init(motor, amount: 1)
    ],
    machine: assembler,
    duration: 12
)

let heatSinkRecipe = Recipe(
    name: "Heat Sink",
    input: [
        .init(alcladAluminumSheet, amount: 8),
        .init(rubber, amount: 14)
    ],
    output: [
        .init(heatSink, amount: 2)
    ],
    machine: assembler,
    duration: 12
)

let heatSinkRecipe1 = Recipe(
    name: "Alternate: Heat Exchanger",
    input: [
        .init(alcladAluminumSheet, amount: 20),
        .init(copperSheet, amount: 30)
    ],
    output: [
        .init(alcladAluminumSheet, amount: 7)
    ],
    machine: assembler,
    duration: 32,
    isDefault: false
)

// MARK: - Electronics
let circuitBoardRecipe = Recipe(
    name: "Circuit Board",
    input: [
        .init(copperSheet, amount: 2),
        .init(plastic, amount: 4)
    ],
    output: [
        .init(circuitBoard, amount: 1)
    ],
    machine: assembler,
    duration: 8
)

let circuitBoardRecipe1 = Recipe(
    name: "Alternate: Electrode Circuit Board",
    input: [
        .init(rubber, amount: 6),
        .init(petroleumCoke, amount: 9)
    ],
    output: [
        .init(circuitBoard, amount: 1)
    ],
    machine: assembler,
    duration: 12,
    isDefault: false
)

let circuitBoardRecipe2 = Recipe(
    name: "Alternate: Silicone Circuit Board",
    input: [
        .init(copperSheet, amount: 11),
        .init(silica, amount: 11)
    ],
    output: [
        .init(circuitBoard, amount: 5)
    ],
    machine: assembler,
    duration: 24,
    isDefault: false
)

let circuitBoardRecipe3 = Recipe(
    name: "Alternate: Caterium Circuit Board",
    input: [
        .init(plastic, amount: 10),
        .init(quickwire, amount: 30)
    ],
    output: [
        .init(circuitBoard, amount: 7)
    ],
    machine: assembler,
    duration: 48,
    isDefault: false
)

let aiLimiterRecipe = Recipe(
    name: "A. I. Limiter",
    input: [
        .init(copperSheet, amount: 5),
        .init(quickwire, amount: 20)
    ],
    output: [
        .init(aiLimiter, amount: 1)
    ],
    machine: assembler,
    duration: 12
)

let wireRecipe3 = Recipe(
    name: "Alternate: Fused Wire",
    input: [
        .init(copperIngot, amount: 4),
        .init(cateriumIngot, amount: 1)
    ],
    output: [
        .init(wire, amount: 30)
    ],
    machine: assembler,
    duration: 20,
    isDefault: false
)

let cableRecipe1 = Recipe(
    name: "Alternate: Insulated Cable",
    input: [
        .init(wire, amount: 9),
        .init(rubber, amount: 6)
    ],
    output: [
        .init(cable, amount: 20)
    ],
    machine: assembler,
    duration: 12,
    isDefault: false
)

let cableRecipe2 = Recipe(
    name: "Alternate: Quickwire Cable",
    input: [
        .init(quickwire, amount: 3),
        .init(rubber, amount: 2)
    ],
    output: [
        .init(cable, amount: 11)
    ],
    machine: assembler,
    duration: 24,
    isDefault: false
)

let quickwireRecipe1 = Recipe(
    name: "Alternate: Fused Quickwire",
    input: [
        .init(cateriumIngot, amount: 1),
        .init(copperIngot, amount: 5)
    ],
    output: [
        .init(quickwire, amount: 12)
    ],
    machine: assembler,
    duration: 8,
    isDefault: false
)

// MARK: - Minerals
let concreteRecipe1 = Recipe(
    name: "Alternate: Rubber Concrete",
    input: [
        .init(limestone, amount: 10),
        .init(rubber, amount: 2)
    ],
    output: [
        .init(concrete, amount: 9)
    ],
    machine: assembler,
    duration: 12,
    isDefault: false
)

let concreteRecipe2 = Recipe(
    name: "Alternate: Fine Concrete",
    input: [
        .init(limestone, amount: 12),
        .init(silica, amount: 3)
    ],
    output: [
        .init(concrete, amount: 10)
    ],
    machine: assembler,
    duration: 24,
    isDefault: false
)

let compactedCoalRecipe = Recipe(
    name: "Alternate: Compacted Coal",
    input: [
        .init(coal, amount: 5),
        .init(sulfur, amount: 5)
    ],
    output: [
        .init(compactedCoal, amount: 5)
    ],
    machine: assembler,
    duration: 12,
    isDefault: false
)

let silicaRecipe1 = Recipe(
    name: "Alternate: Cheap Silica",
    input: [
        .init(rawQuartz, amount: 3),
        .init(limestone, amount: 5)
    ],
    output: [
        .init(silica, amount: 7)
    ],
    machine: assembler,
    duration: 16,
    isDefault: false
)

// MARK: - Communications
let computerRecipe1 = Recipe(
    name: "Alternate: Crystal Compute",
    input: [
        .init(circuitBoard, amount: 8),
        .init(crystalOscillator, amount: 3)
    ],
    output: [
        .init(computer, amount: 3)
    ],
    machine: assembler,
    duration: 64,
    isDefault: false
)

// MARK: - Nuclear
let electromagneticControlRodRecipe = Recipe(
    name: "Electromagnetic Control Rod",
    input: [
        .init(stator, amount: 3),
        .init(aiLimiter, amount: 2)
    ],
    output: [
        .init(electromagneticControlRod, amount: 2)
    ],
    machine: assembler,
    duration: 30
)

let electromagneticControlRodRecipe1 = Recipe(
    name: "Alternate: Electromagnetic Connection Rod",
    input: [
        .init(stator, amount: 10),
        .init(highSpeedConnector, amount: 5)
    ],
    output: [
        .init(electromagneticControlRod, amount: 10)
    ],
    machine: assembler,
    duration: 60,
    isDefault: false
)

let encasedUraniumCellRecipe = Recipe(
    name: "Encased Uranium Cell",
    input: [
        .init(uraniumPellet, amount: 40),
        .init(concrete, amount: 9)
    ],
    output: [
        .init(encasedUraniumCell, amount: 10)
    ],
    machine: assembler,
    duration: 60
)

// MARK: - Consumed
let blackPowderRecipe = Recipe(
    name: "Black Powder",
    input: [
        .init(coal, amount: 1),
        .init(sulfur, amount: 2)
    ],
    output: [
        .init(blackPowder, amount: 1)
    ],
    machine: assembler,
    duration: 8
)

let blackPowderRecipe1 = Recipe(
    name: "Alternate: Fine Black Powder",
    input: [
        .init(sulfur, amount: 2),
        .init(compactedCoal, amount: 1)
    ],
    output: [
        .init(blackPowder, amount: 4)
    ],
    machine: assembler,
    duration: 16,
    isDefault: false
)

let nobeliskRecipe = Recipe(
    name: "Nobelisk",
    input: [
        .init(blackPowder, amount: 5),
        .init(steelPipe, amount: 10)
    ],
    output: [
        .init(nobelisk, amount: 1)
    ],
    machine: assembler,
    duration: 20
)

// MARK: - Space Elevator
let smartPlatingRecipe = Recipe(
    name: "Smart Plating",
    input: [
        .init(reinforcedIronPlate, amount: 1),
        .init(rotor, amount: 1)
    ],
    output: [
        .init(smartPlating, amount: 1)
    ],
    machine: assembler,
    duration: 30
)

let versatileFrameworkRecipe = Recipe(
    name: "Versatile Framework",
    input: [
        .init(modularFrame, amount: 1),
        .init(steelBeam, amount: 12)
    ],
    output: [
        .init(versatileFramework, amount: 2)
    ],
    machine: assembler,
    duration: 24
)

let automatedWiringRecipe = Recipe(
    name: "Automated Wiring",
    input: [
        .init(stator, amount: 1),
        .init(cable, amount: 20)
    ],
    output: [
        .init(automatedWiring, amount: 1)
    ],
    machine: assembler,
    duration: 24
)

// MARK: - Biomass
let fabricRecipe = Recipe(
    name: "Fabric",
    input: [
        .init(mycelia, amount: 1),
        .init(biomass, amount: 5)
    ],
    output: [
        .init(fabric, amount: 1)
    ],
    machine: assembler,
    duration: 4
)

let assemblerRecipes = [
    reinforcedIronPlateRecipe,
    reinforcedIronPlateRecipe1,
    reinforcedIronPlateRecipe2,
    reinforcedIronPlateRecipe3,
    modularFrameRecipe,
    modularFrameRecipe1,
    modularFrameRecipe2,
    ironPlateRecipe1,
    ironPlateRecipe2,
    encasedIndustrialBeamRecipe,
    encasedIndustrialBeamRecipe1,
    alcladAluminumSheetRecipe,
    
    rotorRecipe,
    rotorRecipe1,
    rotorRecipe2,
    statorRecipe,
    statorRecipe1,
    motorRecipe,
    heatSinkRecipe,
    heatSinkRecipe1,
    
    circuitBoardRecipe,
    circuitBoardRecipe1,
    circuitBoardRecipe2,
    circuitBoardRecipe3,
    aiLimiterRecipe,
    wireRecipe3,
    cableRecipe1,
    cableRecipe2,
    quickwireRecipe1,
    
    concreteRecipe1,
    concreteRecipe2,
    compactedCoalRecipe,
    silicaRecipe1,
    
    computerRecipe1,
    
    electromagneticControlRodRecipe,
    electromagneticControlRodRecipe1,
    encasedUraniumCellRecipe,
    
    blackPowderRecipe,
    blackPowderRecipe1,
    nobeliskRecipe,
    
    smartPlatingRecipe,
    versatileFrameworkRecipe,
    automatedWiringRecipe,
    
    fabricRecipe,
]
