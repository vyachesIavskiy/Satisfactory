// MARK: - Standart Parts
let ironPlateRecipe = Recipe(input: [
    .init(ironIngot, amount: 30)
    ], output: [
        .init(ironPlate, amount: 20)
], machine: constructor)

let ironRodRecipe = Recipe(input: [
    .init(ironIngot, amount: 15)
    ], output: [
        .init(ironRod, amount: 15)
], machine: constructor)

let ironRodRecipe1 = Recipe(input: [
    .init(steelIngot, amount: 12)
    ], output: [
        .init(ironRod, amount: 48)
], machine: constructor, isDefault: false)

let screwRecipe = Recipe(input: [
    .init(ironRod, amount: 10)
    ], output: [
        .init(screw, amount: 40)
], machine: constructor)

let screwRecipe1 = Recipe(input: [
    .init(ironIngot, amount: 12.5)
    ], output: [
        .init(screw, amount: 50)
], machine: constructor, isDefault: false)

let screwRecipe2 = Recipe(input: [
    .init(steelBeam, amount: 5)
    ], output: [
        .init(screw, amount: 260)
], machine: constructor, isDefault: false)

let copperSheetRecipe = Recipe(input: [
    .init(copperIngot, amount: 20)
    ], output: [
        .init(copperSheet, amount: 10)
], machine: constructor)

let steelBeamRecipe = Recipe(input: [
    .init(steelIngot, amount: 60)
    ], output: [
        .init(steelBeam, amount: 15)
], machine: constructor)

let steelPipeRecipe = Recipe(input: [
    .init(steelIngot, amount: 30)
    ], output: [
        .init(steelPipe, amount: 20)
], machine: constructor)

// MARK: - Electronics
let wireRecipe = Recipe(input: [
    .init(copperIngot, amount: 15)
    ], output: [
        .init(wire, amount: 30)
], machine: constructor)

let wireRecipe1 = Recipe(input: [
    .init(ironIngot, amount: 12.5)
    ], output: [
        .init(wire, amount: 22.5)
], machine: constructor, isDefault: false)

let wireRecipe2 = Recipe(input: [
    .init(cateriumIngot, amount: 15)
    ], output: [
        .init(wire, amount: 120)
], machine: constructor, isDefault: false)

let cableRecipe = Recipe(input: [
    .init(wire, amount: 60)
    ], output: [
        .init(cable, amount: 30)
], machine: constructor)

let quickWireRecipe = Recipe(input: [
    .init(cateriumIngot, amount: 12)
    ], output: [
        .init(quickwire, amount: 60)
], machine: constructor)

// MARK: - Minerals
let concreteRecipe = Recipe(input: [
    .init(limestone, amount: 45)
    ], output: [
        .init(concrete, amount: 15)
], machine: constructor)

let quartzCrystalRecipe = Recipe(input: [
    .init(rawQuartz, amount: 37.5)
    ], output: [
        .init(quartzCrystal, amount: 22.5)
], machine: constructor)

let silicaRecipe = Recipe(input: [
    .init(rawQuartz, amount: 22.5)
    ], output: [
        .init(silica, amount: 37.5)
], machine: constructor)

// MARK: - Biomass
let biomassWoodRecipe = Recipe(input: [
    .init(wood, amount: 60)
    ], output: [
        .init(biomass, amount: 300)
], machine: constructor)

let biomassLeavesRecipe = Recipe(input: [
    .init(leaves, amount: 120)
    ], output: [
        .init(biomass, amount: 60)
], machine: constructor)

let biomassAlienCarapaceRecipe = Recipe(input: [
    .init(alienCarapace, amount: 15)
    ], output: [
        .init(biomass, amount: 1_500)
], machine: constructor)

let biomassAlienOrgansRecipe = Recipe(input: [
    .init(alienOrgans, amount: 7.5)
    ], output: [
        .init(biomass, amount: 1_500)
], machine: constructor)

let biomassMyceliaRecipe = Recipe(input: [
    .init(mycelia, amount: 150)
    ], output: [
        .init(biomass, amount: 150)
], machine: constructor)

let solidBiofuelRecipe = Recipe(input: [
    .init(biomass, amount: 120)
    ], output: [
        .init(solidBiofuel, amount: 60)
], machine: constructor)

// MARK: - Raw materials
let charcoalRecipe = Recipe(input: [
    .init(wood, amount: 15)
    ], output: [
        .init(coal, amount: 150)
], machine: constructor, isDefault: false)

let bioCoalRecipe = Recipe(input: [
    .init(biomass, amount: 37.5)
    ], output: [
        .init(coal, amount: 45)
], machine: constructor, isDefault: false)

// MARK: - Power Shards
let powerShard1Recipe = Recipe(input: [
    .init(greenPowerSlug, amount: 6)
    ], output: [
        .init(powerShard, amount: 6)
], machine: constructor)

let powerShard2Recipe = Recipe(input: [
    .init(yellowPowerSlug, amount: 4)
    ], output: [
        .init(powerShard, amount: 8)
], machine: constructor)

let powerShard5Recipe = Recipe(input: [
    .init(purplePowerSlug, amount: 3)
    ], output: [
        .init(powerShard, amount: 15)
], machine: constructor)

// MARK: - Consumed
let colorCartridgeRecipe = Recipe(input: [
    .init(flowerPetals, amount: 37.5)
    ], output: [
        .init(colorCartridge, amount: 75)
], machine: constructor)

let spikedRebarRecipe = Recipe(input: [
    .init(ironRod, amount: 15)
    ], output: [
        .init(spikedRebar, amount: 15)
], machine: constructor)

// MARK: - Other
let emptyCanisterRecipe = Recipe(input: [
    .init(plastic, amount: 30)
    ], output: [
        .init(emptyCanister, amount: 10)
], machine: constructor)

let constructorRecipes = [
    ironPlateRecipe,
    ironRodRecipe,
    ironRodRecipe1,
    screwRecipe,
    screwRecipe1,
    screwRecipe2,
    copperSheetRecipe,
    steelBeamRecipe,
    steelPipeRecipe,
    
    wireRecipe,
    wireRecipe1,
    wireRecipe2,
    cableRecipe,
    quickWireRecipe,
    
    concreteRecipe,
    quartzCrystalRecipe,
    silicaRecipe,
    
    biomassWoodRecipe,
    biomassLeavesRecipe,
    biomassAlienCarapaceRecipe,
    biomassAlienOrgansRecipe,
    biomassMyceliaRecipe,
    solidBiofuelRecipe,
    
    charcoalRecipe,
    bioCoalRecipe,
    
    powerShard1Recipe,
    powerShard2Recipe,
    powerShard5Recipe,
    
    colorCartridgeRecipe,
    spikedRebarRecipe,
    
    emptyCanisterRecipe
]
