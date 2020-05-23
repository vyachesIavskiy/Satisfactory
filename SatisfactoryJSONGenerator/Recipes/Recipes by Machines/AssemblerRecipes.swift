// MARK: - Standart Parts
let reinforcedIronPlateRecipe = Recipe(input: [
    .init(ironPlate, amount: 30),
    .init(screw, amount: 60)
    ], output: [
        .init(reinforcedIronPlate, amount: 5)
], machine: assembler)

let reinforcedIronPlateRecipe1 = Recipe(input: [
    .init(ironPlate, amount: 11.25),
    .init(rubber, amount: 3.75)
    ], output: [
        .init(reinforcedIronPlate, amount: 3.8)
], machine: assembler, isDefault: false)

let reinforcedIronPlateRecipe2 = Recipe(input: [
    .init(ironPlate, amount: 90),
    .init(screw, amount: 50)
    ], output: [
        .init(reinforcedIronPlate, amount: 15)
], machine: assembler, isDefault: false)

let reinforcedIronPlateRecipe3 = Recipe(input: [
    .init(ironPlate, amount: 18.75),
    .init(wire, amount: 37.5)
    ], output: [
        .init(reinforcedIronPlate, amount: 5.6)
], machine: assembler, isDefault: false)

let modularFrameRecipe = Recipe(input: [
    .init(reinforcedIronPlate, amount: 3),
    .init(ironRod, amount: 12)
    ], output: [
        .init(modularFrame, amount: 2)
], machine: assembler)

let modularFrameRecipe1 = Recipe(input: [
    .init(reinforcedIronPlate, amount: 7.5),
    .init(screw, amount: 140)
    ], output: [
        .init(modularFrame, amount: 5)
], machine: assembler, isDefault: false)

let modularFrameRecipe2 = Recipe(input: [
    .init(reinforcedIronPlate, amount: 2),
    .init(steelPipe, amount: 10)
    ], output: [
        .init(modularFrame, amount: 3)
], machine: assembler, isDefault: false)

let ironPlateRecipe1 = Recipe(input: [
    .init(ironIngot, amount: 50),
    .init(plastic, amount: 10)
    ], output: [
        .init(ironPlate, amount: 75)
], machine: assembler, isDefault: false)

let ironPlateRecipe2 = Recipe(input: [
    .init(steelIngot, amount: 7.5),
    .init(plastic, amount: 5)
    ], output: [
        .init(ironPlate, amount: 45)
], machine: assembler, isDefault: false)

let encasedIndustrialBeamRecipe = Recipe(input: [
    .init(steelBeam, amount: 24),
    .init(concrete, amount: 30)
    ], output: [
        .init(encasedIndustrialBeam, amount: 6)
], machine: assembler)

let encasedIndustrialBeamRecipe1 = Recipe(input: [
    .init(steelPipe, amount: 28),
    .init(concrete, amount: 20)
    ], output: [
        .init(encasedIndustrialBeam, amount: 4)
], machine: assembler, isDefault: false)

let alcladAluminumSheetRecipe = Recipe(input: [
    .init(aluminumIngot, amount: 60),
    .init(copperIngot, amount: 22.5)
    ], output: [
        .init(alcladAluminumSheet, amount: 30)
], machine: assembler)

// MARK: - Industrial Parts
let rotorRecipe = Recipe(input: [
    .init(ironRod, amount: 20),
    .init(screw, amount: 100)
    ], output: [
        .init(rotor, amount: 4)
], machine: assembler)

let rotorRecipe1 = Recipe(input: [
    .init(copperSheet, amount: 22.5),
    .init(screw, amount: 52)
    ], output: [
        .init(rotor, amount: 11.2)
], machine: assembler, isDefault: false)

let rotorRecipe2 = Recipe(input: [
    .init(steelPipe, amount: 10),
    .init(wire, amount: 30)
    ], output: [
        .init(rotor, amount: 5)
], machine: assembler, isDefault: false)

let statorRecipe = Recipe(input: [
    .init(steelPipe, amount: 15),
    .init(wire, amount: 40)
    ], output: [
        .init(stator, amount: 5)
], machine: assembler)

let statorRecipe1 = Recipe(input: [
    .init(steelPipe, amount: 16),
    .init(quickWire, amount: 60)
    ], output: [
        .init(stator, amount: 8)
], machine: assembler, isDefault: false)

let motorRecipe = Recipe(input: [
    .init(rotor, amount: 10),
    .init(stator, amount: 10)
    ], output: [
        .init(motor, amount: 5)
], machine: assembler)

let heatSinkRecipe = Recipe(input: [
    .init(alcladAluminumSheet, amount: 40),
    .init(rubber, amount: 70)
    ], output: [
        .init(heatSink, amount: 10)
], machine: assembler)

let heatSinkRecipe1 = Recipe(input: [
    .init(alcladAluminumSheet, amount: 37.5)
    ], output: [
        .init(copperSheet, amount: 56.25)
], machine: assembler, isDefault: false)

// MARK: - Electronics
let circuitBoardRecipe = Recipe(input: [
    .init(copperSheet, amount: 15),
    .init(plastic, amount: 30)
    ], output: [
        .init(circuitBoard, amount: 7.5)
], machine: assembler)

let circuitBoardRecipe1 = Recipe(input: [
    .init(rubber, amount: 30),
    .init(petroleumCoke, amount: 45)
    ], output: [
        .init(circuitBoard, amount: 5)
], machine: assembler, isDefault: false)

let circuitBoardRecipe2 = Recipe(input: [
    .init(copperSheet, amount: 27.5),
    .init(silica, amount: 27.5)
    ], output: [
        .init(circuitBoard, amount: 12.5)
], machine: assembler, isDefault: false)

let circuitBoardRecipe3 = Recipe(input: [
    .init(plastic, amount: 12.5),
    .init(quickWire, amount: 37.5)
    ], output: [
        .init(circuitBoard, amount: 8.8)
], machine: assembler, isDefault: false)

let aiLimiterRecipe = Recipe(input: [
    .init(copperSheet, amount: 25),
    .init(quickWire, amount: 100)
    ], output: [
        .init(aiLimiter, amount: 5)
], machine: assembler)

let wireRecipe3 = Recipe(input: [
    .init(copperIngot, amount: 12),
    .init(cateriumIngot, amount: 3)
    ], output: [
        .init(wire, amount: 90)
], machine: assembler, isDefault: false)

let cableRecipe1 = Recipe(input: [
    .init(wire, amount: 45),
    .init(rubber, amount: 30)
    ], output: [
        .init(cable, amount: 100)
], machine: assembler, isDefault: false)

let cableRecipe2 = Recipe(input: [
    .init(quickWire, amount: 7.5),
    .init(rubber, amount: 5)
    ], output: [
        .init(cable, amount: 27.5)
], machine: assembler, isDefault: false)

let quickWireRecipe1 = Recipe(input: [
    .init(cateriumIngot, amount: 7.5),
    .init(copperIngot, amount: 37.5)
    ], output: [
        .init(quickWire, amount: 90)
], machine: assembler, isDefault: false)

// MARK: - Minerals
let concreteRecipe1 = Recipe(input: [
    .init(limestone, amount: 50),
    .init(rubber, amount: 10)
    ], output: [
        .init(concrete, amount: 45)
], machine: assembler, isDefault: false)

let concreteRecipe2 = Recipe(input: [
    .init(limestone, amount: 30),
    .init(silica, amount: 7.5)
    ], output: [
        .init(concrete, amount: 25)
], machine: assembler, isDefault: false)

let compactedCoalRecipe = Recipe(input: [
    .init(coal, amount: 25),
    .init(sulfur, amount: 25)
    ], output: [
        .init(compactedCoal, amount: 25)
], machine: assembler, isDefault: false)

let silicaRecipe1 = Recipe(input: [
    .init(rawQuartz, amount: 11.25),
    .init(limestone, amount: 18.75)
    ], output: [
        .init(silica, amount: 26.2)
], machine: assembler, isDefault: false)

// MARK: - Biomass
let fabricRecipe = Recipe(input: [
    .init(mycelia, amount: 15),
    .init(biomass, amount: 75)
    ], output: [
        .init(fabric, amount: 15)
], machine: assembler)

// MARK: - Communications
let computerRecipe1 = Recipe(input: [
    .init(circuitBoard, amount: 7.5),
    .init(crystalOscillator, amount: 2.813)
    ], output: [
        .init(computer, amount: 2.8)
], machine: assembler, isDefault: false)

// MARK: - Nuclear
let electromagneticControlRodRecipe = Recipe(input: [
    .init(stator, amount: 6),
    .init(aiLimiter, amount: 4)
    ], output: [
        .init(electromagneticControlRod, amount: 4)
], machine: assembler)

let electromagneticControlRodRecipe1 = Recipe(input: [
    .init(stator, amount: 10),
    .init(highSpeedConnector, amount: 5)
    ], output: [
        .init(electromagneticControlRod, amount: 10)
], machine: assembler, isDefault: false)

let encasedUraniumCellRecipe = Recipe(input: [
    .init(uraniumPellet, amount: 40),
    .init(concrete, amount: 9)
    ], output: [
        .init(encasedUraniumCell, amount: 10)
], machine: assembler)

// MARK: - Consumed
let blackPowderRecipe = Recipe(input: [
    .init(coal, amount: 7.5),
    .init(sulfur, amount: 15)
    ], output: [
        .init(blackPowder, amount: 7.5)
], machine: assembler)

let blackPowderRecipe1 = Recipe(input: [
    .init(sulfur, amount: 7.5),
    .init(compactedCoal, amount: 3.75)
    ], output: [
        .init(blackPowder, amount: 15)
], machine: assembler, isDefault: false)

let nobeliskRecipe = Recipe(input: [
    .init(blackPowder, amount: 15),
    .init(steelPipe, amount: 30)
    ], output: [
        .init(nobelisk, amount: 3)
], machine: assembler)

// MARK: - Space Elevator
let smartPlatingRecipe = Recipe(input: [
    .init(reinforcedIronPlate, amount: 2),
    .init(rotor, amount: 2)
    ], output: [
        .init(smartPlating, amount: 2)
], machine: assembler)

let versatileFrameworkRecipe = Recipe(input: [
    .init(modularFrame, amount: 2.5),
    .init(steelBeam, amount: 30)
    ], output: [
        .init(versatileFramework, amount: 5)
], machine: assembler)

let automatedWiringRecipe = Recipe(input: [
    .init(stator, amount: 2.5),
    .init(cable, amount: 50)
    ], output: [
        .init(automatedWiring, amount: 2.5)
], machine: assembler)

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
    quickWireRecipe1,
    
    concreteRecipe1,
    concreteRecipe2,
    compactedCoalRecipe,
    silicaRecipe1,
    
    fabricRecipe,
    
    computerRecipe1,
    
    electromagneticControlRodRecipe,
    electromagneticControlRodRecipe1,
    encasedUraniumCellRecipe,
    
    blackPowderRecipe,
    blackPowderRecipe1,
    nobeliskRecipe,
    
    smartPlatingRecipe,
    versatileFrameworkRecipe,
    automatedWiringRecipe
]
