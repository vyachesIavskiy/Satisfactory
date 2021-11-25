// MARK: - Industrial Parts
let coolingSystemRecipe = Recipe(
    name: "Cooling System",
    input: [
        .init(heatSink, amount: 2),
        .init(rubber, amount: 2),
        .init(water, amount: 5),
        .init(nitrogenGas, amount: 25)
    ],
    output: [
        .init(coolingSystem, amount: 1)
    ],
    machines: [blender],
    duration: 10
)

let coolingSystemRecipe1 = Recipe(
    name: "Alternate: Cooling Device",
    input: [
        .init(heatSink, amount: 5),
        .init(motor, amount: 1),
        .init(nitrogenGas, amount: 24)
    ],
    output: [
        .init(coolingSystem, amount: 2)
    ],
    machines: [blender],
    duration: 32,
    isDefault: false
)

let fusedModularFrameRecipe = Recipe(
    name: "Fused Modular Frame",
    input: [
        .init(heavyModularFrame, amount: 1),
        .init(aluminumCasing, amount: 50),
        .init(nitrogenGas, amount: 25)
    ],
    output: [
        .init(fusedModularFrame, amount: 1)
    ],
    machines: [blender],
    duration: 40
)

let fusedModularFrameRecipe1 = Recipe(
    name: "Alternate: Heat-Fused Frame",
    input: [
        .init(heavyModularFrame, amount: 1),
        .init(aluminumIngot, amount: 50),
        .init(nitricAcid, amount: 8),
        .init(fuel, amount: 10)
    ],
    output: [
        .init(fusedModularFrame, amount: 1)
    ],
    machines: [blender],
    duration: 20,
    isDefault: false
)

let batteryRecipe = Recipe(
    name: "Battery",
    input: [
        .init(sulfuricAcid, amount: 2.5),
        .init(aluminaSolution, amount: 2),
        .init(aluminumCasing, amount: 1)
    ],
    output: [
        .init(battery, amount: 1),
        .init(water, amount: 1.5)
    ],
    machines: [blender],
    duration: 3
)

// MARK: - Fuel
let fuelRecipe2 = Recipe(
    name: "Alternate: Diluted Fuel",
    input: [
        .init(heavyOilResidue, amount: 5),
        .init(water, amount: 10)
    ],
    output: [
        .init(fuel, amount: 10)
    ],
    machines: [blender],
    duration: 6,
    isDefault: false
)

let turbofuelRecipe2 = Recipe(
    name: "Alternate: Turbo Blend Fuel",
    input: [
        .init(fuel, amount: 2),
        .init(heavyOilResidue, amount: 4),
        .init(sulfur, amount: 3),
        .init(petroleumCoke, amount: 3)
    ],
    output: [
        .init(turbofuel, amount: 6)
    ],
    machines: [blender],
    duration: 8,
    isDefault: false
)

// MARK: - Nuclear
let nonFissileUraniumRecipe = Recipe(
    name: "Non-fissile Uranium",
    input: [
        .init(uraniumWaste, amount: 15),
        .init(silica, amount: 10),
        .init(nitricAcid, amount: 6),
        .init(sulfuricAcid, amount: 6)
    ],
    output: [
        .init(nonFissileUranium, amount: 20),
        .init(water, amount: 6)
    ],
    machines: [blender],
    duration: 24
)

let nonFissileUraniumRecipe1 = Recipe(
    name: "Alternate: Fertile Uranium",
    input: [
        .init(uranium, amount: 5),
        .init(uraniumWaste, amount: 5),
        .init(nitricAcid, amount: 3),
        .init(sulfuricAcid, amount: 5)
    ],
    output: [
        .init(nonFissileUranium, amount: 20),
        .init(water, amount: 8)
    ],
    machines: [blender],
    duration: 12,
    isDefault: false
)

let encasedUraniumCellRecipe = Recipe(
    name: "Encased Uranium Cell",
    input: [
        .init(uranium, amount: 10),
        .init(concrete, amount: 3),
        .init(sulfuricAcid, amount: 8)
    ],
    output: [
        .init(encasedUraniumCell, amount: 5),
        .init(sulfuricAcid, amount: 2)
    ],
    machines: [blender],
    duration: 12
)

// MARK: - Andvanced Refinement
let nitricAcidRecipe = Recipe(
    name: "Nitric Acid",
    input: [
        .init(nitrogenGas, amount: 12),
        .init(water, amount: 3),
        .init(ironPlate, amount: 1)
    ],
    output: [
        .init(nitricAcid, amount: 3)
    ],
    machines: [blender],
    duration: 6
)

let aluminumScrapRecipe2 = Recipe(
    name: "Alternate: Instant Scrap",
    input: [
        .init(bauxite, amount: 15),
        .init(coal, amount: 10),
        .init(sulfuricAcid, amount: 5),
        .init(water, amount: 6)
    ],
    output: [
        .init(aluminumScrap, amount: 30),
        .init(water, amount: 5)
    ],
    machines: [blender],
    duration: 6,
    isDefault: false
)

let BlenderRecipes = [
    // Industrial parts
    coolingSystemRecipe,
    coolingSystemRecipe1,
    fusedModularFrameRecipe,
    fusedModularFrameRecipe1,
    batteryRecipe,
    
    // Fuel
    fuelRecipe2,
    turbofuelRecipe2,
    
    // Nuclear
    nonFissileUraniumRecipe,
    nonFissileUraniumRecipe1,
    encasedUraniumCellRecipe,
    
    // Advanced Refinement
    nitricAcidRecipe,
    aluminumScrapRecipe2
]
