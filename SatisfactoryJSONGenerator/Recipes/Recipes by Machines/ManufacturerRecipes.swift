// MARK: - Standart Parts
let heavyModularFrameRecipe = Recipe(input: [
    .init(modularFrame, amount: 10),
    .init(steelPipe, amount: 30),
    .init(encasedIndustrialBeam, amount: 10),
    .init(screw, amount: 200)
    ], output: [
        .init(heavyModularFrame, amount: 2)
], machine: manufacturer)

let heavyModularFrameRecipe1 = Recipe(input: [
    .init(modularFrame, amount: 18.75),
    .init(encasedIndustrialBeam, amount: 11.25),
    .init(rubber, amount: 75),
    .init(screw, amount: 390)
    ], output: [
        .init(heavyModularFrame, amount: 3.8)
], machine: manufacturer, isDefault: false)

let heavyModularFrameRecipe2 = Recipe(input: [
    .init(modularFrame, amount: 7.5),
    .init(encasedIndustrialBeam, amount: 9.375),
    .init(steelPipe, amount: 33.75),
    .init(concrete, amount: 20.625)
    ], output: [
        .init(heavyModularFrame, amount: 2.8)
], machine: manufacturer, isDefault: false)

// MARK: - Industrial Parts
let turboMotorRecipe = Recipe(input: [
    .init(heatSink, amount: 7.5),
    .init(radioControlUnit, amount: 3.75),
    .init(motor, amount: 7.5),
    .init(rubber, amount: 45)
    ], output: [
        .init(turboMotor, amount: 1.9)
], machine: manufacturer)

let turboMotorRecipe1 = Recipe(input: [
    .init(motor, amount: 6.563),
    .init(radioControlUnit, amount: 4.688),
    .init(aiLimiter, amount: 8.438),
    .init(stator, amount: 6.563)
    ], output: [
        .init(turboMotor, amount: 2.8)
], machine: manufacturer, isDefault: false)

let motorRecipe1 = Recipe(input: [
    .init(rotor, amount: 3.75),
    .init(stator, amount: 3.75),
    .init(crystalOscillator, amount: 1.25)
    ], output: [
        .init(motor, amount: 7.5)
], machine: manufacturer, isDefault: false)

// MARK: - Electronics
let highSpeedConnectorRecipe = Recipe(input: [
    .init(quickWire, amount: 210),
    .init(cable, amount: 37.5),
    .init(circuitBoard, amount: 3.75)
    ], output: [
        .init(highSpeedConnector, amount: 3.8),
], machine: manufacturer)

let highSpeedConnectorRecipe1 = Recipe(input: [
    .init(quickWire, amount: 90),
    .init(silica, amount: 37.5),
    .init(circuitBoard, amount: 3)
    ], output: [
        .init(highSpeedConnector, amount: 3),
], machine: manufacturer, isDefault: false)

let batteryRecipe = Recipe(input: [
    .init(alcladAluminumSheet, amount: 15),
    .init(wire, amount: 30),
    .init(sulfur, amount: 37.5),
    .init(plastic, amount: 15)
    ], output: [
        .init(battery, amount: 5.6)
], machine: manufacturer)

// MARK: - Communications
let computerRecipe = Recipe(input: [
    .init(circuitBoard, amount: 25),
    .init(cable, amount: 22.5),
    .init(plastic, amount: 45),
    .init(screw, amount: 130)
    ], output: [
        .init(computer, amount: 2.5)
], machine: manufacturer)

let computerRecipe2 = Recipe(input: [
    .init(circuitBoard, amount: 26.25),
    .init(quickWire, amount: 105),
    .init(rubber, amount: 45)
    ], output: [
        .init(computer, amount: 3.8),
], machine: manufacturer, isDefault: false)

let crystalOscillatorRecipe = Recipe(input: [
    .init(quartzCrystal, amount: 18),
    .init(cable, amount: 14),
    .init(reinforcedIronPlate, amount: 2.5)
    ], output: [
        .init(crystalOscillator, amount: 1)
], machine: manufacturer)

let crystalOscillatorRecipe1 = Recipe(input: [
    .init(quartzCrystal, amount: 18.75),
    .init(rubber, amount: 13.125),
    .init(aiLimiter, amount: 1.875)
    ], output: [
        .init(crystalOscillator, amount: 1.9)
], machine: manufacturer, isDefault: false)

let radioControlUnitRecipe = Recipe(input: [
    .init(heatSink, amount: 10),
    .init(rubber, amount: 40),
    .init(crystalOscillator, amount: 2.5),
    .init(computer, amount: 2.5)
    ], output: [
        .init(radioControlUnit, amount: 2.5)
], machine: manufacturer)

let radioControlUnitRecipe1 = Recipe(input: [
    .init(heatSink, amount: 12.5),
    .init(supercomputer, amount: 1.25),
    .init(quartzCrystal, amount: 37.5)
    ], output: [
        .init(radioControlUnit, amount: 3.8)
], machine: manufacturer, isDefault: false)

let supercomputerRecipe = Recipe(input: [
    .init(computer, amount: 3.75),
    .init(aiLimiter, amount: 3.75),
    .init(highSpeedConnector, amount: 5.625),
    .init(plastic, amount: 52.2)
    ], output: [
        .init(supercomputer, amount: 1.9)
], machine: manufacturer)

// MARK: - Nuclear
let nuclearFuelRodRecipe = Recipe(input: [
    .init(encasedUraniumCell, amount: 10),
    .init(encasedIndustrialBeam, amount: 1.2),
    .init(electromagneticControlRod, amount: 2)
    ], output: [
        .init(nuclearFuelRod, amount: 0.4)
], machine: manufacturer)

let nuclearFuelRodRecipe1 = Recipe(input: [
    .init(encasedUraniumCell, amount: 10),
    .init(electromagneticControlRod, amount: 2),
    .init(crystalOscillator, amount: 0.6),
    .init(beacon, amount: 1.2)
    ], output: [
        .init(nuclearFuelRod, amount: 0.6)
], machine: manufacturer, isDefault: false)

let encasedUraniumCellRecipe1 = Recipe(input: [
    .init(uraniumPellet, amount: 20),
    .init(sulfur, amount: 22.5),
    .init(silica, amount: 22.5),
    .init(quickWire, amount: 37.5)
    ], output: [
        .init(encasedUraniumCell, amount: 17.5)
], machine: manufacturer, isDefault: false)

// MARK: - Consumed
let gasFilterRecipe = Recipe(input: [
    .init(coal, amount: 37.5),
    .init(rubber, amount: 15),
    .init(fabric, amount: 15)
    ], output: [
        .init(gasFilter, amount: 7.5)
], machine: manufacturer)

let iodineInfusedFilterRecipe = Recipe(input: [
    .init(gasFilter, amount: 3.75),
    .init(quickWire, amount: 30),
    .init(rubber, amount: 7.5)
    ], output: [
        .init(iodineInfusedFilter, amount: 3.8)
], machine: manufacturer)

let rifleCartridgeRecipe = Recipe(input: [
    .init(beacon, amount: 3),
    .init(steelPipe, amount: 30),
    .init(blackPowder, amount: 30),
    .init(rubber, amount: 30)
    ], output: [
        .init(rifleCartridge, amount: 15)
], machine: manufacturer)

let nobeliskRecipe1 = Recipe(input: [
    .init(blackPowder, amount: 12),
    .init(steelPipe, amount: 12),
    .init(crystalOscillator, amount: 1.5)
    ], output: [
        .init(nobelisk, amount: 6)
], machine: manufacturer, isDefault: false)

// MARK: - Space Elevator
let modularEngineRecipe = Recipe(input: [
    .init(motor, amount: 2),
    .init(rubber, amount: 15),
    .init(smartPlating, amount: 2)
    ], output: [
        .init(modularEngine, amount: 1)
], machine: manufacturer)

let adaptiveControlUnitRecipe = Recipe(input: [
    .init(automatedWiring, amount: 7.5),
    .init(circuitBoard, amount: 5),
    .init(heavyModularFrame, amount: 1),
    .init(computer, amount: 1)
    ], output: [
        .init(adaptiveControlUnit, amount: 1)
], machine: manufacturer)

let smartPlatingRecipe1 = Recipe(input: [
    .init(reinforcedIronPlate, amount: 2.5),
    .init(rotor, amount: 2.5),
    .init(plastic, amount: 7.5)
    ], output: [
        .init(smartPlating, amount: 5)
], machine: manufacturer, isDefault: false)

let versatileFrameworkRecipe1 = Recipe(input: [
    .init(modularFrame, amount: 3.75),
    .init(steelBeam, amount: 22.5),
    .init(rubber, amount: 30)
    ], output: [
        .init(versatileFramework, amount: 7.5)
], machine: manufacturer, isDefault: false)

let automatedWiringRecipe1 = Recipe(input: [
    .init(stator, amount: 3.75),
    .init(wire, amount: 75),
    .init(highSpeedConnector, amount: 1.875)
    ], output: [
        .init(automatedWiring, amount: 7.5)
], machine: manufacturer, isDefault: false)

// MARK: - Hands
let beaconRecipe = Recipe(input: [
    .init(ironPlate, amount: 22.5),
    .init(ironRod, amount: 7.5),
    .init(wire, amount: 112.5),
    .init(cable, amount: 15)
    ], output: [
        .init(beacon, amount: 7.5)
], machine: manufacturer)

let beaconRecipe1 = Recipe(input: [
    .init(steelBeam, amount: 2),
    .init(steelPipe, amount: 8),
    .init(crystalOscillator, amount: 0.5)
    ], output: [
        .init(beacon, amount: 10)
], machine: manufacturer, isDefault: false)

let manufacturerRecipes = [
    heavyModularFrameRecipe,
    heavyModularFrameRecipe1,
    heavyModularFrameRecipe2,
    
    turboMotorRecipe,
    turboMotorRecipe1,
    motorRecipe1,
    
    highSpeedConnectorRecipe,
    highSpeedConnectorRecipe1,
    batteryRecipe,
    
    computerRecipe,
    computerRecipe2,
    crystalOscillatorRecipe,
    crystalOscillatorRecipe1,
    radioControlUnitRecipe,
    radioControlUnitRecipe1,
    supercomputerRecipe,
    
    nuclearFuelRodRecipe,
    nuclearFuelRodRecipe1,
    encasedUraniumCellRecipe1,
    
    gasFilterRecipe,
    iodineInfusedFilterRecipe,
    rifleCartridgeRecipe,
    nobeliskRecipe1,
    
    modularEngineRecipe,
    adaptiveControlUnitRecipe,
    smartPlatingRecipe1,
    versatileFrameworkRecipe1,
    automatedWiringRecipe1,
    
    beaconRecipe,
    beaconRecipe1
]
