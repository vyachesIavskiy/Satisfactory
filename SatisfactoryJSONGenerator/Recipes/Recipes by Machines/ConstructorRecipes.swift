// MARK: - Standart Parts
let ironPlateRecipe = Recipe(input: [
    .init(ironIngot, amount: 3)
    ], output: [
        .init(ironPlate, amount: 2)
], machine: constructor, duration: 6)

let ironRodRecipe = Recipe(input: [
    .init(ironIngot, amount: 1)
    ], output: [
        .init(ironRod, amount: 1)
], machine: constructor, duration: 4)

let ironRodRecipe1 = Recipe(input: [
    .init(steelIngot, amount: 1)
    ], output: [
        .init(ironRod, amount: 4)
], machine: constructor, duration: 5, isDefault: false)

let screwRecipe = Recipe(input: [
    .init(ironRod, amount: 1)
    ], output: [
        .init(screw, amount: 4)
], machine: constructor, duration: 6)

let screwRecipe1 = Recipe(input: [
    .init(ironIngot, amount: 5)
    ], output: [
        .init(screw, amount: 20)
], machine: constructor, duration: 24, isDefault: false)

let screwRecipe2 = Recipe(input: [
    .init(steelBeam, amount: 1)
    ], output: [
        .init(screw, amount: 52)
], machine: constructor, duration: 12, isDefault: false)

let copperSheetRecipe = Recipe(input: [
    .init(copperIngot, amount: 2)
    ], output: [
        .init(copperSheet, amount: 1)
], machine: constructor, duration: 6)

let steelBeamRecipe = Recipe(input: [
    .init(steelIngot, amount: 4)
    ], output: [
        .init(steelBeam, amount: 1)
], machine: constructor, duration: 4)

let steelPipeRecipe = Recipe(input: [
    .init(steelIngot, amount: 3)
    ], output: [
        .init(steelPipe, amount: 2)
], machine: constructor, duration: 6)

// MARK: - Electronics
let wireRecipe = Recipe(input: [
    .init(copperIngot, amount: 1)
    ], output: [
        .init(wire, amount: 2)
], machine: constructor, duration: 4)

let wireRecipe1 = Recipe(input: [
    .init(ironIngot, amount: 5)
    ], output: [
        .init(wire, amount: 9)
], machine: constructor, duration: 24, isDefault: false)

let wireRecipe2 = Recipe(input: [
    .init(cateriumIngot, amount: 1)
    ], output: [
        .init(wire, amount: 8)
], machine: constructor, duration: 4, isDefault: false)

let cableRecipe = Recipe(input: [
    .init(wire, amount: 2)
    ], output: [
        .init(cable, amount: 1)
], machine: constructor, duration: 2)

let quickWireRecipe = Recipe(input: [
    .init(cateriumIngot, amount: 1)
    ], output: [
        .init(quickwire, amount: 5)
], machine: constructor, duration: 5)

// MARK: - Minerals
let concreteRecipe = Recipe(input: [
    .init(limestone, amount: 3)
    ], output: [
        .init(concrete, amount: 1)
], machine: constructor, duration: 4)

let quartzCrystalRecipe = Recipe(input: [
    .init(rawQuartz, amount: 5)
    ], output: [
        .init(quartzCrystal, amount: 3)
], machine: constructor, duration: 8)

let silicaRecipe = Recipe(input: [
    .init(rawQuartz, amount: 3)
    ], output: [
        .init(silica, amount: 5)
], machine: constructor, duration: 8)

// MARK: - Biomass
let biomassWoodRecipe = Recipe(input: [
    .init(wood, amount: 4)
    ], output: [
        .init(biomass, amount: 20)
], machine: constructor, duration: 4)

let biomassLeavesRecipe = Recipe(input: [
    .init(leaves, amount: 10)
    ], output: [
        .init(biomass, amount: 5)
], machine: constructor, duration: 5)

let biomassAlienCarapaceRecipe = Recipe(input: [
    .init(alienCarapace, amount: 1)
    ], output: [
        .init(biomass, amount: 100)
], machine: constructor, duration: 4)

let biomassAlienOrgansRecipe = Recipe(input: [
    .init(alienOrgans, amount: 1)
    ], output: [
        .init(biomass, amount: 200)
], machine: constructor, duration: 8)

let biomassMyceliaRecipe = Recipe(input: [
    .init(mycelia, amount: 10)
    ], output: [
        .init(biomass, amount: 10)
], machine: constructor, duration: 4)

let solidBiofuelRecipe = Recipe(input: [
    .init(biomass, amount: 8)
    ], output: [
        .init(solidBiofuel, amount: 4)
], machine: constructor, duration: 4)

// MARK: - Raw materials
let charcoalRecipe = Recipe(input: [
    .init(wood, amount: 1)
    ], output: [
        .init(coal, amount: 10)
], machine: constructor, duration: 4, isDefault: false)

let bioCoalRecipe = Recipe(input: [
    .init(biomass, amount: 5)
    ], output: [
        .init(coal, amount: 6)
], machine: constructor, duration: 8, isDefault: false)

// MARK: - Containers
let emptyCanisterRecipe = Recipe(input: [
    .init(plastic, amount: 2)
    ], output: [
        .init(emptyCanister, amount: 4)
], machine: constructor, duration: 4)

// MARK: - Consumed
let spikedRebarRecipe = Recipe(input: [
    .init(ironRod, amount: 1)
    ], output: [
        .init(spikedRebar, amount: 1)
], machine: constructor, duration: 4)

let colorCartridgeRecipe = Recipe(input: [
    .init(flowerPetals, amount: 5)
    ], output: [
        .init(colorCartridge, amount: 10)
], machine: constructor, duration: 8)

// MARK: - Power Shards
let powerShard1Recipe = Recipe(input: [
    .init(greenPowerSlug, amount: 1)
    ], output: [
        .init(powerShard, amount: 1)
], machine: constructor, duration: 8)

let powerShard2Recipe = Recipe(input: [
    .init(yellowPowerSlug, amount: 1)
    ], output: [
        .init(powerShard, amount: 2)
], machine: constructor, duration: 12)

let powerShard5Recipe = Recipe(input: [
    .init(purplePowerSlug, amount: 1)
    ], output: [
        .init(powerShard, amount: 5)
], machine: constructor, duration: 24)

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
    
    emptyCanisterRecipe,
    
    spikedRebarRecipe,
    colorCartridgeRecipe,
    
    powerShard1Recipe,
    powerShard2Recipe,
    powerShard5Recipe,
]
