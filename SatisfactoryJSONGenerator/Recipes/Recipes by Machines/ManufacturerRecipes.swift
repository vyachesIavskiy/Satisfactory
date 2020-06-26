// MARK: - Standart Parts
let heavyModularFrameRecipe = Recipe(
    name: "Heavy Modular Frame",
    input: [
        .init(modularFrame, amount: 5),
        .init(steelPipe, amount: 15),
        .init(encasedIndustrialBeam, amount: 5),
        .init(screw, amount: 100)
    ],
    output: [
        .init(heavyModularFrame, amount: 1)
    ],
    machine: manufacturer,
    duration: 30
)

let heavyModularFrameRecipe1 = Recipe(
    name: "Alternate: Heavy Flexible Frame",
    input: [
        .init(modularFrame, amount: 5),
        .init(encasedIndustrialBeam, amount: 3),
        .init(rubber, amount: 20),
        .init(screw, amount: 104)
    ],
    output: [
        .init(heavyModularFrame, amount: 1)
    ],
    machine: manufacturer,
    duration: 16,
    isDefault: false
)

let heavyModularFrameRecipe2 = Recipe(
    name: "Alternate: Heavy Encased Frame",
    input: [
        .init(modularFrame, amount: 8),
        .init(encasedIndustrialBeam, amount: 10),
        .init(steelPipe, amount: 36),
        .init(concrete, amount: 22)
    ],
    output: [
        .init(heavyModularFrame, amount: 3)
    ],
    machine: manufacturer,
    duration: 64,
    isDefault: false
)

// MARK: - Industrial Parts
let turboMotorRecipe = Recipe(
    name: "Turbo Motor",
    input: [
        .init(heatSink, amount: 4),
        .init(radioControlUnit, amount: 2),
        .init(motor, amount: 4),
        .init(rubber, amount: 24)
    ],
    output: [
        .init(turboMotor, amount: 1)
    ],
    machine: manufacturer,
    duration: 32
)

let turboMotorRecipe1 = Recipe(
    name: "Alternate: Turbo Rigour Motor",
    input: [
        .init(motor, amount: 7),
        .init(radioControlUnit, amount: 5),
        .init(aiLimiter, amount: 9),
        .init(stator, amount: 7)
    ],
    output: [
        .init(turboMotor, amount: 3)
    ],
    machine: manufacturer,
    duration: 64,
    isDefault: false
)

let motorRecipe1 = Recipe(
    name: "Alternate: Rigour Motor",
    input: [
        .init(rotor, amount: 3),
        .init(stator, amount: 3),
        .init(crystalOscillator, amount: 1)
    ],
    output: [
        .init(motor, amount: 6)
    ],
    machine: manufacturer,
    duration: 48,
    isDefault: false
)

// MARK: - Electronics
let highSpeedConnectorRecipe = Recipe(
    name: "High-Speed Connector",
    input: [
        .init(quickwire, amount: 56),
        .init(cable, amount: 10),
        .init(circuitBoard, amount: 1)
    ],
    output: [
        .init(highSpeedConnector, amount: 1),
    ],
    machine: manufacturer,
    duration: 16
)

let highSpeedConnectorRecipe1 = Recipe(
    name: "Alternate: Silicone High-Speed Connector",
    input: [
        .init(quickwire, amount: 60),
        .init(silica, amount: 25),
        .init(circuitBoard, amount: 2)
    ],
    output: [
        .init(highSpeedConnector, amount: 2),
    ],
    machine: manufacturer,
    duration: 40,
    isDefault: false
)

let batteryRecipe = Recipe(
    name: "Battery",
    input: [
        .init(alcladAluminumSheet, amount: 8),
        .init(wire, amount: 16),
        .init(sulfur, amount: 20),
        .init(plastic, amount: 8)
    ],
    output: [
        .init(battery, amount: 3)
    ],
    machine: manufacturer,
    duration: 32
)

// MARK: - Communications
let computerRecipe = Recipe(
    name: "Computer",
    input: [
        .init(circuitBoard, amount: 10),
        .init(cable, amount: 9),
        .init(plastic, amount: 18),
        .init(screw, amount: 52)
    ],
    output: [
        .init(computer, amount: 1)
    ],
    machine: manufacturer,
    duration: 24
)

let computerRecipe2 = Recipe(
    name: "Alternate: Caterium Computer",
    input: [
        .init(circuitBoard, amount: 7),
        .init(quickwire, amount: 28),
        .init(rubber, amount: 12)
    ],
    output: [
        .init(computer, amount: 1),
    ],
    machine: manufacturer,
    duration: 16,
    isDefault: false
)

let crystalOscillatorRecipe = Recipe(
    name: "Crystal Oscillator",
    input: [
        .init(quartzCrystal, amount: 36),
        .init(cable, amount: 28),
        .init(reinforcedIronPlate, amount: 5)
    ],
    output: [
        .init(crystalOscillator, amount: 2)
    ],
    machine: manufacturer,
    duration: 120
)

let crystalOscillatorRecipe1 = Recipe(
    name: "Alternate: Insulated Crystal Oscillator",
    input: [
        .init(quartzCrystal, amount: 10),
        .init(rubber, amount: 7),
        .init(aiLimiter, amount: 1)
    ],
    output: [
        .init(crystalOscillator, amount: 1)
    ],
    machine: manufacturer,
    duration: 32,
    isDefault: false
)

let supercomputerRecipe = Recipe(
    name: "Supercomputer",
    input: [
        .init(computer, amount: 2),
        .init(aiLimiter, amount: 2),
        .init(highSpeedConnector, amount: 3),
        .init(plastic, amount: 28)
    ],
    output: [
        .init(supercomputer, amount: 1)
    ],
    machine: manufacturer,
    duration: 32
)

let radioControlUnitRecipe = Recipe(
    name: "Radio Control Unit",
    input: [
        .init(heatSink, amount: 4),
        .init(rubber, amount: 16),
        .init(crystalOscillator, amount: 1),
        .init(computer, amount: 1)
    ],
    output: [
        .init(radioControlUnit, amount: 1)
    ],
    machine: manufacturer,
    duration: 24
)

let radioControlUnitRecipe1 = Recipe(
    name: "Alternate: Radio Control System",
    input: [
        .init(heatSink, amount: 10),
        .init(supercomputer, amount: 1),
        .init(quartzCrystal, amount: 30)
    ],
    output: [
        .init(radioControlUnit, amount: 3)
    ],
    machine: manufacturer,
    duration: 48,
    isDefault: false
)

// MARK: - Nuclear
let nuclearFuelRodRecipe = Recipe(
    name: "Nuclear Fuel Rod",
    input: [
        .init(encasedUraniumCell, amount: 25),
        .init(encasedIndustrialBeam, amount: 3),
        .init(electromagneticControlRod, amount: 5)
    ],
    output: [
        .init(nuclearFuelRod, amount: 1)
    ],
    machine: manufacturer,
    duration: 150
)

let nuclearFuelRodRecipe1 = Recipe(
    name: "Alternate: Nuclear Fuel Unit",
    input: [
        .init(encasedUraniumCell, amount: 50),
        .init(electromagneticControlRod, amount: 10),
        .init(crystalOscillator, amount: 3),
        .init(beacon, amount: 6)
    ],
    output: [
        .init(nuclearFuelRod, amount: 3)
    ],
    machine: manufacturer,
    duration: 300,
    isDefault: false
)

let encasedUraniumCellRecipe1 = Recipe(
    name: "Alternate: Infused Uranium Cell",
    input: [
        .init(uraniumPellet, amount: 40),
        .init(sulfur, amount: 45),
        .init(silica, amount: 45),
        .init(quickwire, amount: 75)
    ],
    output: [
        .init(encasedUraniumCell, amount: 35)
    ],
    machine: manufacturer,
    duration: 120,
    isDefault: false
)

// MARK: - Consumed
let gasFilterRecipe = Recipe(
    name: "Gas Filter",
    input: [
        .init(coal, amount: 5),
        .init(rubber, amount: 2),
        .init(fabric, amount: 2)
    ],
    output: [
        .init(gasFilter, amount: 1)
    ],
    machine: manufacturer,
    duration: 8
)

let iodineInfusedFilterRecipe = Recipe(
    name: "Iodine Infused Filter",
    input: [
        .init(gasFilter, amount: 1),
        .init(quickwire, amount: 8),
        .init(rubber, amount: 2)
    ],
    output: [
        .init(iodineInfusedFilter, amount: 1)
    ],
    machine: manufacturer,
    duration: 16
)

let rifleCartridgeRecipe = Recipe(
    name: "Rifle Cartridge",
    input: [
        .init(beacon, amount: 1),
        .init(steelPipe, amount: 10),
        .init(blackPowder, amount: 10),
        .init(rubber, amount: 10)
    ],
    output: [
        .init(rifleCartridge, amount: 5)
    ],
    machine: manufacturer,
    duration: 20
)

let nobeliskRecipe1 = Recipe(
    name: "Alternate: Seismic Nobelisk",
    input: [
        .init(blackPowder, amount: 8),
        .init(steelPipe, amount: 8),
        .init(crystalOscillator, amount: 1)
    ],
    output: [
        .init(nobelisk, amount: 4)
    ],
    machine: manufacturer,
    duration: 40,
    isDefault: false
)

// MARK: - Space Elevator
let modularEngineRecipe = Recipe(
    name: "Modular Engine",
    input: [
        .init(motor, amount: 2),
        .init(rubber, amount: 15),
        .init(smartPlating, amount: 2)
    ],
    output: [
        .init(modularEngine, amount: 1)
    ],
    machine: manufacturer,
    duration: 60
)

let adaptiveControlUnitRecipe = Recipe(
    name: "Adaptive Control Unit",
    input: [
        .init(automatedWiring, amount: 15),
        .init(circuitBoard, amount: 10),
        .init(heavyModularFrame, amount: 2),
        .init(computer, amount: 2)
    ],
    output: [
        .init(adaptiveControlUnit, amount: 2)
    ],
    machine: manufacturer,
    duration: 120
)

let smartPlatingRecipe1 = Recipe(
    name: "Alternate: Plastic Smart Plating",
    input: [
        .init(reinforcedIronPlate, amount: 1),
        .init(rotor, amount: 1),
        .init(plastic, amount: 3)
    ],
    output: [
        .init(smartPlating, amount: 2)
    ],
    machine: manufacturer,
    duration: 24,
    isDefault: false
)

let versatileFrameworkRecipe1 = Recipe(
    name: "Alternate: Flexible Framework",
    input: [
        .init(modularFrame, amount: 1),
        .init(steelBeam, amount: 6),
        .init(rubber, amount: 8)
    ],
    output: [
        .init(versatileFramework, amount: 2)
    ],
    machine: manufacturer,
    duration: 16,
    isDefault: false
)

let automatedWiringRecipe1 = Recipe(
    name: "Alternate: Automated Speed Wiring",
    input: [
        .init(stator, amount: 2),
        .init(wire, amount: 40),
        .init(highSpeedConnector, amount: 1)
    ],
    output: [
        .init(automatedWiring, amount: 4)
    ],
    machine: manufacturer,
    duration: 32,
    isDefault: false
)

// MARK: - Hands
let beaconRecipe = Recipe(
    name: "Beacon",
    input: [
        .init(ironPlate, amount: 3),
        .init(ironRod, amount: 1),
        .init(wire, amount: 15),
        .init(cable, amount: 2)
    ],
    output: [
        .init(beacon, amount: 1)
    ],
    machine: manufacturer,
    duration: 8
)

let beaconRecipe1 = Recipe(
    name: "Alternate: Crystal Beacon",
    input: [
        .init(steelBeam, amount: 4),
        .init(steelPipe, amount: 16),
        .init(crystalOscillator, amount: 1)
    ],
    output: [
        .init(beacon, amount: 20)
    ],
    machine: manufacturer,
    duration: 120,
    isDefault: false
)

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
    supercomputerRecipe,
    radioControlUnitRecipe,
    radioControlUnitRecipe1,
    
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
