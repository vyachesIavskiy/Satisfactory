// MARK: - Standart Parts
let ironPlateRecipe = Recipe(
    name: "Iron Plate",
    input: [
        .init(ironIngot, amount: 3)
    ],
    output: [
        .init(ironPlate, amount: 2)
    ],
    machines: [constructor],
    duration: 6
)

let ironRodRecipe = Recipe(
    name: "Iron Rod",
    input: [
        .init(ironIngot, amount: 1)
    ],
    output: [
        .init(ironRod, amount: 1)
    ],
    machines: [constructor],
    duration: 4
)

let ironRodRecipe1 = Recipe(
    name: "Alternate: Steel Rod",
    input: [
        .init(steelIngot, amount: 1)
    ],
    output: [
        .init(ironRod, amount: 4)
    ],
    machines: [constructor],
    duration: 5,
    isDefault: false
)

let screwRecipe = Recipe(
    name: "Screw",
    input: [
        .init(ironRod, amount: 1)
    ],
    output: [
        .init(screw, amount: 4)
    ],
    machines: [constructor],
    duration: 6
)

let screwRecipe1 = Recipe(
    name: "Alternate: Cast Screw",
    input: [
        .init(ironIngot, amount: 5)
    ],
    output: [
        .init(screw, amount: 20)
    ],
    machines: [constructor],
    duration: 24,
    isDefault: false
)

let screwRecipe2 = Recipe(
    name: "Alternate: Steel Screw",
    input: [
        .init(steelBeam, amount: 1)
    ],
    output: [
        .init(screw, amount: 52)
    ],
    machines: [constructor],
    duration: 12,
    isDefault: false
)

let copperSheetRecipe = Recipe(
    name: "Copper Sheet",
    input: [
        .init(copperIngot, amount: 2)
    ],
    output: [
        .init(copperSheet, amount: 1)
    ],
    machines: [constructor],
    duration: 6
)

let steelBeamRecipe = Recipe(
    name: "Steel Beam",
    input: [
        .init(steelIngot, amount: 4)
    ],
    output: [
        .init(steelBeam, amount: 1)
    ],
    machines: [constructor],
    duration: 4
)

let steelPipeRecipe = Recipe(
    name: "Steel Pipe",
    input: [
        .init(steelIngot, amount: 3)
    ],
    output: [
        .init(steelPipe, amount: 2)
    ],
    machines: [constructor],
    duration: 6
)

let aluminumCasingRecipe = Recipe(
    name: "Aluminum Casing",
    input: [
        .init(aluminumIngot, amount: 3)
    ],
    output: [
        .init(aluminumCasing, amount: 2)
    ],
    machines: [constructor],
    duration: 2
)

// MARK: - Electronics
let wireRecipe = Recipe(
    name: "Wire",
    input: [
        .init(copperIngot, amount: 1)
    ],
    output: [
        .init(wire, amount: 2)
    ],
    machines: [constructor],
    duration: 4
)

let wireRecipe1 = Recipe(
    name: "Alternate: Iron Wire",
    input: [
        .init(ironIngot, amount: 5)
    ],
    output: [
        .init(wire, amount: 9)
    ],
    machines: [constructor],
    duration: 24,
    isDefault: false
)

let wireRecipe2 = Recipe(
    name: "Alternate: Caterium wire",
    input: [
        .init(cateriumIngot, amount: 1)
    ],
    output: [
        .init(wire, amount: 8)
    ],
    machines: [constructor],
    duration: 4,
    isDefault: false
)

let cableRecipe = Recipe(
    name: "Cable",
    input: [
        .init(wire, amount: 2)
    ],
    output: [
        .init(cable, amount: 1)
    ],
    machines: [constructor],
    duration: 2
)

let quickwireRecipe = Recipe(
    name: "Quickwire",
    input: [
        .init(cateriumIngot, amount: 1)
    ],
    output: [
        .init(quickwire, amount: 5)
    ],
    machines: [constructor],
    duration: 5
)

// MARK: - Minerals
let concreteRecipe = Recipe(
    name: "Concrete",
    input: [
        .init(limestone, amount: 3)
    ],
    output: [
        .init(concrete, amount: 1)
    ],
    machines: [constructor],
    duration: 4
)

let quartzCrystalRecipe = Recipe(
    name: "Quartz Crystal",
    input: [
        .init(rawQuartz, amount: 5)
    ],
    output: [
        .init(quartzCrystal, amount: 3)
    ],
    machines: [constructor],
    duration: 8
)

let silicaRecipe = Recipe(
    name: "Silica",
    input: [
        .init(rawQuartz, amount: 3)
    ],
    output: [
        .init(silica, amount: 5)
    ],
    machines: [constructor],
    duration: 8
)

let copperPowderRecipe = Recipe(
    name: "Copper Powder",
    input: [
        .init(copperIngot, amount: 30)
    ],
    output: [
        .init(copperPowder, amount: 5)
    ],
    machines: [constructor],
    duration: 6
)

// MARK: - Biomass
let biomassLeavesRecipe = Recipe(
    name: "Biomass (Leaves)",
    input: [
        .init(leaves, amount: 10)
    ],
    output: [
        .init(biomass, amount: 5)
    ],
    machines: [constructor],
    duration: 5
)

let biomassWoodRecipe = Recipe(
    name: "Biomass (Wood)",
    input: [
        .init(wood, amount: 4)
    ],
    output: [
        .init(biomass, amount: 20)
    ],
    machines: [constructor],
    duration: 4
)

let biomassAlienCarapaceRecipe = Recipe(
    name: "Biomass (Alien Carapace)",
    input: [
        .init(alienCarapace, amount: 1)
    ],
    output: [
        .init(biomass, amount: 100)
    ],
    machines: [constructor],
    duration: 4
)

let biomassAlienOrgansRecipe = Recipe(
    name: "Biomass (Alien Organs)",
    input: [
        .init(alienOrgans, amount: 1)
    ],
    output: [
        .init(biomass, amount: 200)
    ],
    machines: [constructor],
    duration: 8
)

let biomassMyceliaRecipe = Recipe(
    name: "Biomass (Mycelia)",
    input: [
        .init(mycelia, amount: 10)
    ],
    output: [
        .init(biomass, amount: 10)
    ],
    machines: [constructor],
    duration: 4
)

let solidBiofuelRecipe = Recipe(
    name: "Solid Biofuel",
    input: [
        .init(biomass, amount: 8)
    ],
    output: [
        .init(solidBiofuel, amount: 4)
    ],
    machines: [constructor],
    duration: 4
)

// MARK: - Raw Materials
let bioCoalRecipe = Recipe(
    name: "Alternate: Biocoal",
    input: [
        .init(biomass, amount: 5)
    ],
    output: [
        .init(coal, amount: 6)
    ],
    machines: [constructor],
    duration: 8,
    isDefault: false
)

let charcoalRecipe = Recipe(
    name: "Alternate: Charcoal",
    input: [
        .init(wood, amount: 1)
    ],
    output: [
        .init(coal, amount: 10)
    ],
    machines: [constructor],
    duration: 4,
    isDefault: false
)

// MARK: - Containers
let emptyCanisterRecipe = Recipe(
    name: "Empty Canister",
    input: [
        .init(plastic, amount: 2)
    ],
    output: [
        .init(emptyCanister, amount: 4)
    ],
    machines: [constructor],
    duration: 4
)

let emptyCanisterRecipe1 = Recipe(
    name: "Alternate: Steel Canister",
    input: [
        .init(steelIngot, amount: 3)
    ],
    output: [
        .init(emptyCanister, amount: 2)
    ],
    machines: [constructor],
    duration: 3,
    isDefault: false
)

let emptyFluidTankRecipe = Recipe(
    name: "Empty Fluid Tank",
    input: [
        .init(aluminumIngot, amount: 1)
    ],
    output: [
        .init(emptyFluidTank, amount: 1)
    ],
    machines: [constructor],
    duration: 1
)

// MARK: - Consumed
let spikedRebarRecipe = Recipe(
    name: "Spiked Rebar",
    input: [
        .init(ironRod, amount: 1)
    ],
    output: [
        .init(spikedRebar, amount: 1)
    ],
    machines: [constructor],
    duration: 4
)

let colorCartridgeRecipe = Recipe(
    name: "Color Cartridge",
    input: [
        .init(flowerPetals, amount: 5)
    ],
    output: [
        .init(colorCartridge, amount: 10)
    ],
    machines: [constructor],
    duration: 8
)

// MARK: - Power Shards
let powerShard1Recipe = Recipe(
    name: "Power Shard (1)",
    input: [
        .init(greenPowerSlug, amount: 1)
    ],
    output: [
        .init(powerShard, amount: 1)
    ],
    machines: [constructor],
    duration: 8
)

let powerShard2Recipe = Recipe(
    name: "Power Shard (2)",
    input: [
        .init(yellowPowerSlug, amount: 1)
    ],
    output: [
        .init(powerShard, amount: 2)
    ],
    machines: [constructor],
    duration: 12
)

let powerShard5Recipe = Recipe(
    name: "Power Shard (5)",
    input: [
        .init(purplePowerSlug, amount: 1)
    ],
    output: [
        .init(powerShard, amount: 5)
    ],
    machines: [constructor],
    duration: 24
)

let ConstructorRecipes = [
    // Standard Parts
    ironPlateRecipe,
    ironRodRecipe,
    ironRodRecipe1,
    screwRecipe,
    screwRecipe1,
    screwRecipe2,
    copperSheetRecipe,
    steelBeamRecipe,
    steelPipeRecipe,
    aluminumCasingRecipe,
    
    // Electronics
    wireRecipe,
    wireRecipe1,
    wireRecipe2,
    cableRecipe,
    quickwireRecipe,
    
    // Minerals
    concreteRecipe,
    quartzCrystalRecipe,
    silicaRecipe,
    copperPowderRecipe,
    
    // Biomass
    biomassWoodRecipe,
    biomassLeavesRecipe,
    biomassAlienCarapaceRecipe,
    biomassAlienOrgansRecipe,
    biomassMyceliaRecipe,
    solidBiofuelRecipe,
    
    // Raw Materials
    charcoalRecipe,
    bioCoalRecipe,
    
    // Containers
    emptyCanisterRecipe,
    emptyCanisterRecipe1,
    emptyFluidTankRecipe,
    
    // Consumed
    spikedRebarRecipe,
    colorCartridgeRecipe,
    
    // Power Shards
    powerShard1Recipe,
    powerShard2Recipe,
    powerShard5Recipe,
]
