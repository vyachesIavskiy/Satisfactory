import Foundation

private extension Recipe {
    init(input: [RecipePart], building: Building) {
        self.init(name: building.name, input: input, output: [.init(building)], machines: [], duration: 0)
    }
}

let theHUBRecipe = Recipe(
    input: [
        .init(hubParts, amount: 1)
    ],
    building: hub
)

let craftBenchRecipe = Recipe(
    input: [
        .init(ironPlate, amount: 3),
        .init(ironRod, amount: 3)
    ],
    building: craftBench
)

let equipmentWorkshopRecipe = Recipe(
    input: [
        .init(ironRod, amount: 10)
    ],
    building: equipmentWorkshop
)

let smelterRecipe = Recipe(
    input: [
        .init(ironRod, amount: 5),
        .init(wire, amount: 8)
    ],
    building: smelter
)

let constructorRecipe = Recipe(
    input: [
        .init(reinforcedIronPlate, amount: 2),
        .init(cable, amount: 8)
    ], building: constructor
)

let powerPoleMK1Recipe = Recipe(
    input: [
        .init(wire, amount: 3),
        .init(ironRod, amount: 1),
        .init(concrete, amount: 1)
    ],
    building: powerPoleMK1
)

let conveyorPoleRecipe = Recipe(
    input: [
        .init(ironRod, amount: 1),
        .init(ironPlate, amount: 1),
        .init(concrete, amount: 1)
    ],
    building: conveyorPole
)

let conveyorBeltMK1Recipe = Recipe(
    input: [
        .init(ironPlate, amount: 1)
    ],
    building: conveyorBeltMK1
)

let minerMK1Recipe = Recipe(
    input: [
        .init(portableMiner, amount: 1),
        .init(ironPlate, amount: 10),
        .init(concrete, amount: 10)
    ],
    building: minerMK1
)

let storageContainerRecipe = Recipe(
    input: [
        .init(ironPlate, amount: 10),
        .init(ironRod, amount: 10)
    ],
    building: storageContainer
)

let spaceElevatorRecipe = Recipe(
    input: [
        .init(concrete, amount: 500),
        .init(ironPlate, amount: 250),
        .init(ironRod, amount: 400),
        .init(wire, amount: 1500)
    ],
    building: spaceElevator
)

let biomassBurnerRecipe = Recipe(
    input: [
        .init(ironPlate, amount: 15),
        .init(ironRod, amount: 15),
        .init(wire, amount: 25)
    ],
    building: biomassBurner
)

let lookoutTowerRecipe = Recipe(
    input: [
        .init(ironPlate, amount: 5),
        .init(ironRod, amount: 5)
    ],
    building: lookoutTower
)

let foundation1mRecipe = Recipe(
    input: [
        .init(concrete, amount: 5),
        .init(ironPlate, amount: 2)
    ],
    building: foundation8x1
)

let foundation2mRecipe = Recipe(
    input: [
        .init(concrete, amount: 5),
        .init(ironPlate, amount: 2)
    ],
    building: foundation8x2
)

let foundation4mRecipe = Recipe(
    input: [
        .init(concrete, amount: 5),
        .init(ironPlate, amount: 2)
    ],
    building: foundation8x4
)

let ramp1mRecipe = Recipe(
    input: [
        .init(concrete, amount: 5),
        .init(ironPlate, amount: 2)
    ],
    building: ramp8x1
)

let ramp2mRecipe = Recipe(
    input: [
        .init(concrete, amount: 5),
        .init(ironPlate, amount: 2)
    ],
    building: ramp8x2
)

let ramp4mRecipe = Recipe(
    input: [
        .init(concrete, amount: 5),
        .init(ironPlate, amount: 2)
    ],
    building: ramp8x4
)

let basicWallRecipe = Recipe(
    input: [
        .init(concrete, amount: 2)
    ],
    building: wall8x4
)

// TODO: - Add new buildings here

let conveyorSplitterRecipe = Recipe(
    input: [
        .init(ironPlate, amount: 2),
        .init(cable, amount: 2)
    ],
    building: coveyorSplitter
)

let conveyorMergerRecipe = Recipe(
    input: [
        .init(ironPlate, amount: 2),
        .init(ironRod, amount: 2)
    ],
    building: conveyorMerger
)

let conveyorLiftMK1Recipe = Recipe(
    input: [
        .init(ironPlate, amount: 2)
    ],
    building: conveyorLiftMK1
)

let mamRecipe = Recipe(
    input: [
        .init(reinforcedIronPlate, amount: 5),
        .init(cable, amount: 15),
        .init(wire, amount: 45)
    ],
    building: mam
)

let personalStorageBoxRecipe = Recipe(
    input: [
        .init(ironPlate, amount: 6),
        .init(ironRod, amount: 6)
    ],
    building: personalStorageBox
)

let assemblerRecipe = Recipe(
    input: [
        .init(reinforcedIronPlate, amount: 8),
        .init(rotor, amount: 4),
        .init(cable, amount: 10)
    ],
    building: assembler
)

let awesomeSinkRecipe = Recipe(
    input: [
        .init(reinforcedIronPlate, amount: 15),
        .init(cable, amount: 30),
        .init(concrete, amount: 45)
    ],
    building: awesomeSink
)

let awesomeShopRecipe = Recipe(
    input: [
        .init(screw, amount: 200),
        .init(ironPlate, amount: 10),
        .init(cable, amount: 10)
    ],
    building: awesomeShop
)

let jumpPadRecipe = Recipe(
    input: [
        .init(rotor, amount: 2),
        .init(ironPlate, amount: 15),
        .init(cable, amount: 10)
    ],
    building: jumpPad
)

let ujellyLandingPadRecipe = Recipe(
    input: [
        .init(rotor, amount: 2),
        .init(cable, amount: 20),
        .init(biomass, amount: 200)
    ],
    building: ujellyLandingPad
)

let conveyorBeltMK2Recipe = Recipe(
    input: [
        .init(reinforcedIronPlate, amount: 1)
    ],
    building: conveyorBeltMK2
)

let stackableConveyorPoleRecipe = Recipe(
    input: [
        .init(ironRod, amount: 2),
        .init(ironPlate, amount: 2),
        .init(concrete, amount: 2)
    ],
    building: stackableConveyorPole
)

let conveyorLiftMK2Recipe = Recipe(
    input: [
        .init(reinforcedIronPlate, amount: 2)
    ],
    building: conveyorLiftMK2
)

let coalGeneratorRecipe = Recipe(
    input: [
        .init(reinforcedIronPlate, amount: 20),
        .init(rotor, amount: 10),
        .init(cable, amount: 30)
    ],
    building: coalGenerator
)

let waterExctractorRecipe = Recipe(
    input: [
        .init(copperSheet, amount: 20),
        .init(reinforcedIronPlate, amount: 10),
        .init(rotor, amount: 10)
    ],
    building: waterExctractor
)

let pipelineMK1Recipe = Recipe(
    input: [
        .init(copperSheet, amount: 1)
    ],
    building: pipelineMK1
)

let pipelineSupportRecipe = Recipe(
    input: [
        .init(ironPlate, amount: 2),
        .init(concrete, amount: 2)
    ],
    building: pipelineSupport
)

let pipelineJunctionCrossRecipe = Recipe(
    input: [
        .init(copperSheet, amount: 2)
    ],
    building: pipelineJunctionCross
)

let pipelinePumpMK1Recipe = Recipe(
    input: [
        .init(copperSheet, amount: 2),
        .init(rotor, amount: 2)
    ],
    building: pipelinePumpMK1
)

let fluidBufferRecipe = Recipe(
    input: [
        .init(copperSheet, amount: 10),
        .init(modularFrame, amount: 5)
    ],
    building: fluidBuffer
)

let foundryRecipe = Recipe(
    input: [
        .init(modularFrame, amount: 10),
        .init(rotor, amount: 10),
        .init(concrete, amount: 20)
    ],
    building: foundry
)

let truckStationRecipe = Recipe(
    input: [
        .init(modularFrame, amount: 15),
        .init(rotor, amount: 20),
        .init(cable, amount: 50)
    ],
    building: truckStation
)

let minerMK2Recipe = Recipe(
    input: [
        .init(portableMiner, amount: 2),
        .init(encasedIndustrialBeam, amount: 10),
        .init(steelPipe, amount: 20),
        .init(modularFrame, amount: 10)
    ],
    building: minerMK2
)

let hyperTubeEntranceRecipe = Recipe(
    input: [
        .init(encasedIndustrialBeam, amount: 4),
        .init(rotor, amount: 4),
        .init(steelPipe, amount: 10)
    ],
    building: hyperTubeEntrance
)

let hyperTubeRecipe = Recipe(
    input: [
        .init(copperSheet, amount: 1),
        .init(steelPipe, amount: 1)
    ],
    building: hyperTube
)

let hyperTubeSupportRecipe = Recipe(
    input: [
        .init(ironPlate, amount: 2),
        .init(concrete, amount: 2)
    ],
    building: hyperTubeSupport
)

let stackableHyperTubeSupportRecipe = Recipe(
    input: [
        .init(ironPlate, amount: 4),
        .init(ironRod, amount: 2),
        .init(concrete, amount: 4)
    ],
    building: stackableHyperTubeSupport
)

let powerStorageRecipe = Recipe(
    input: [
        .init(wire, amount: 100),
        .init(modularFrame, amount: 10),
        .init(stator, amount: 5)
    ],
    building: powerStorage
)

let industrialStorageContainerRecipe = Recipe(
    input: [
        .init(steelBeam, amount: 20),
        .init(steelPipe, amount: 20)
    ],
    building: industrialStorageContainer
)

let conveyorBeltMK3Recipe = Recipe(
    input: [
        .init(steelBeam, amount: 1)
    ],
    building: conveyorBeltMK3
)

let conveyorLiftMK3Recipe = Recipe(
    input: [
        .init(steelBeam, amount: 2)
    ],
    building: conveyorLiftMK3
)

let stackablePipelineSupportRecipe = Recipe(
    input: [
        .init(ironPlate, amount: 4),
        .init(ironRod, amount: 2),
        .init(concrete, amount: 2)
    ],
    building: stackablePipelineSupport
)

let oilExctractorRecipe = Recipe(
    input: [
        .init(motor, amount: 15),
        .init(encasedIndustrialBeam, amount: 20),
        .init(cable, amount: 60)
    ],
    building: oilExctractor
)

let refineryRecipe = Recipe(
    input: [
        .init(motor, amount: 10),
        .init(encasedIndustrialBeam, amount: 10),
        .init(steelPipe, amount: 30),
        .init(copperSheet, amount: 20)
    ],
    building: refinery
)

let valveRecipe = Recipe(
    input: [
        .init(rubber, amount: 4),
        .init(steelBeam, amount: 4)
    ],
    building: valve
)

let packagerRecipe = Recipe(
    input: [
        .init(steelBeam, amount: 20),
        .init(rubber, amount: 10),
        .init(plastic, amount: 10)
    ],
    building: packager
)

let industrialFluidBufferRecipe = Recipe(
    input: [
        .init(plastic, amount: 30),
        .init(heavyModularFrame, amount: 3)
    ],
    building: industrialFluidBuffer
)

let manufacturerRecipe = Recipe(
    input: [
        .init(motor, amount: 5),
        .init(heavyModularFrame, amount: 10),
        .init(cable, amount: 50),
        .init(plastic, amount: 50)
    ],
    building: manufacturer
)

let fuelGeneratorRecipe = Recipe(
    input: [
        .init(computer, amount: 5),
        .init(heavyModularFrame, amount: 10),
        .init(motor, amount: 15),
        .init(rubber, amount: 50),
        .init(quickwire, amount: 50)
    ],
    building: fuelGenerator
)

let conveyorBeltMK4Recipe = Recipe(
    input: [
        .init(encasedIndustrialBeam, amount: 1)
    ],
    building: conveyorBeltMK4
)

let conveyorLiftMK4Recipe = Recipe(
    input: [
        .init(encasedIndustrialBeam, amount: 2)
    ],
    building: conveyorLiftMK4
)

let trainStationRecipe = Recipe(
    input: [
        .init(heavyModularFrame, amount: 4),
        .init(computer, amount: 8),
        .init(concrete, amount: 50),
        .init(cable, amount: 25)
    ],
    building: trainStation
)

let freightPlatformRecipe = Recipe(
    input: [
        .init(heavyModularFrame, amount: 6),
        .init(computer, amount: 2),
        .init(concrete, amount: 50),
        .init(cable, amount: 25),
        .init(motor, amount: 5)
    ],
    building: freightPlatform
)

let fluidFreightPlatformRecipe = Recipe(
    input: [
        .init(heavyModularFrame, amount: 6),
        .init(computer, amount: 2),
        .init(concrete, amount: 50),
        .init(cable, amount: 25),
        .init(motor, amount: 5)
    ],
    building: fluidFreightPlatform
)

let emptyPlatformRecipe = Recipe(
    input: [
        .init(heavyModularFrame, amount: 6),
        .init(concrete, amount: 50)
    ],
    building: emptyPlatform
)

// TODO: - Empty Platform with catwalk
// TODO: - Block signal
// TODO: - Path signal

let pipelineMK2Recipe = Recipe(
    input: [
        .init(copperSheet, amount: 2),
        .init(plastic, amount: 1)
    ],
    building: pipelineMK2
)

let pipelinePumpMK2Recipe = Recipe(
    input: [
        .init(motor, amount: 2),
        .init(encasedIndustrialBeam, amount: 4),
        .init(plastic, amount: 8)
    ],
    building: pipelinePumpMK2
)

let blenderRecipe = Recipe(
    input: [
        .init(motor, amount: 20),
        .init(heavyModularFrame, amount: 10),
        .init(aluminumCasing, amount: 50),
        .init(radioControlUnit, amount: 5)
    ],
    building: blender
)

let dronePortRecipe = Recipe(
    input: [
        .init(heavyModularFrame, amount: 20),
        .init(highSpeedConnector, amount: 20),
        .init(alcladAluminumSheet, amount: 50),
        .init(aluminumCasing, amount: 50),
        .init(radioControlUnit, amount: 10)
    ],
    building: dronePort
)

let conveyorBeltMK5Recipe = Recipe(
    input: [
        .init(alcladAluminumSheet, amount: 1)
    ],
    building: conveyorBeltMK5
)

let conveyorLiftMK5Recipe = Recipe(
    input: [
        .init(alcladAluminumSheet, amount: 2)
    ],
    building: conveyorLiftMK5
)

let particleAcceleratorRecipe = Recipe(
    input: [
        .init(radioControlUnit, amount: 25),
        .init(electromagneticControlRod, amount: 100),
        .init(supercomputer, amount: 10),
        .init(coolingSystem, amount: 50),
        .init(fusedModularFrame, amount: 20),
        .init(turboMotor, amount: 10)
    ],
    building: particleAccelerator
)

let nuclearPowerPlantRecipe = Recipe(
    input: [
        .init(concrete, amount: 250),
        .init(heavyModularFrame, amount: 25),
        .init(supercomputer, amount: 5),
        .init(cable, amount: 100),
        .init(alcladAluminumSheet, amount: 100)
    ],
    building: nuclearPowerPlant
)

let TierBuildingRecipes = [
    theHUBRecipe,
    craftBenchRecipe,
    equipmentWorkshopRecipe,
    smelterRecipe,
    constructorRecipe,
    powerPoleMK1Recipe,
    conveyorPoleRecipe,
    conveyorBeltMK1Recipe,
    minerMK1Recipe,
    storageContainerRecipe,
    spaceElevatorRecipe,
    biomassBurnerRecipe,
    lookoutTowerRecipe,
    foundation1mRecipe,
    foundation2mRecipe,
    foundation4mRecipe,
    ramp1mRecipe,
    ramp2mRecipe,
    ramp4mRecipe,
    basicWallRecipe,
    conveyorSplitterRecipe,
    conveyorMergerRecipe,
    conveyorLiftMK1Recipe,
    mamRecipe,
    personalStorageBoxRecipe,
    assemblerRecipe,
    awesomeSinkRecipe,
    awesomeShopRecipe,
    jumpPadRecipe,
    ujellyLandingPadRecipe,
    conveyorBeltMK2Recipe,
    stackableConveyorPoleRecipe,
    conveyorLiftMK2Recipe,
    coalGeneratorRecipe,
    waterExctractorRecipe,
    pipelineMK1Recipe,
    pipelineSupportRecipe,
    pipelineJunctionCrossRecipe,
    pipelinePumpMK1Recipe,
    fluidBufferRecipe,
    foundryRecipe,
    truckStationRecipe,
    minerMK2Recipe,
    hyperTubeEntranceRecipe,
    hyperTubeRecipe,
    hyperTubeSupportRecipe,
    stackableHyperTubeSupportRecipe,
    powerStorageRecipe,
    industrialStorageContainerRecipe,
    conveyorBeltMK3Recipe,
    conveyorLiftMK3Recipe,
    stackablePipelineSupportRecipe,
    oilExctractorRecipe,
    refineryRecipe,
    valveRecipe,
    packagerRecipe,
    industrialFluidBufferRecipe,
    manufacturerRecipe,
    fuelGeneratorRecipe,
    conveyorBeltMK4Recipe,
    conveyorLiftMK4Recipe,
    trainStationRecipe,
    freightPlatformRecipe,
    fluidFreightPlatformRecipe,
    emptyPlatformRecipe,
    pipelineMK2Recipe,
    pipelinePumpMK2Recipe,
    blenderRecipe,
    dronePortRecipe,
    conveyorBeltMK5Recipe,
    conveyorLiftMK5Recipe,
    particleAcceleratorRecipe,
    nuclearPowerPlantRecipe
]
