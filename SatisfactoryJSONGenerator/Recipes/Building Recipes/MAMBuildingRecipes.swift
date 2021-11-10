import Foundation

private extension Recipe {
    init(input: [RecipePart], building: Building) {
        self.init(name: building.name, input: input, output: [.init(building)], machines: [], duration: 0)
    }
}

// MARK: - Caterium
let powerPoleMK2Recipe = Recipe(
    input: [
        .init(quickwire, amount: 6),
        .init(ironRod, amount: 2),
        .init(concrete, amount: 2)
    ],
    building: powerPoleMK2
)

let smartSplitterRecipe = Recipe(
    input: [
        .init(reinforcedIronPlate, amount: 2),
        .init(rotor, amount: 2),
        .init(aiLimiter, amount: 1)
    ],
    building: smartSplitter
)

let powerSwitchRecipe = Recipe(
    input: [
        .init(quickwire, amount: 20),
        .init(steelBeam, amount: 4),
        .init(aiLimiter, amount: 1)
    ],
    building: powerSwitch
)

let powerPoleMK3Recipe = Recipe(
    input: [
        .init(highSpeedConnector, amount: 2),
        .init(steelPipe, amount: 2),
        .init(rubber, amount: 3)
    ],
    building: powerPoleMK3
)

let programmableSplitterRecipe = Recipe(
    input: [
        .init(heavyModularFrame, amount: 1),
        .init(motor, amount: 1),
        .init(supercomputer, amount: 1)
    ],
    building: programmableSplitter
)

let geothermalGeneratorRecipe = Recipe(
    input: [
        .init(supercomputer, amount: 8),
        .init(heavyModularFrame, amount: 16),
        .init(highSpeedConnector, amount: 16),
        .init(copperSheet, amount: 40),
        .init(rubber, amount: 80)
    ],
    building: geothermalGenerator
)

// MARK: - Quartz

let radarTowerRecipe = Recipe(
    input: [
        .init(heavyModularFrame, amount: 30),
        .init(crystalOscillator, amount: 30),
        .init(beacon, amount: 20),
        .init(cable, amount: 100)
    ],
    building: radarTower
)

let MAMBuildingRecipes = [
    powerPoleMK2Recipe,
    smartSplitterRecipe,
    powerSwitchRecipe,
    powerPoleMK3Recipe,
    programmableSplitterRecipe,
    geothermalGeneratorRecipe,
    radarTowerRecipe
]