// MARK: - Nuclear
let plutoniumPelletRecipe = Recipe(
    name: "Plutonium Pellet",
    input: [
        .init(nonFissileUranium, amount: 100),
        .init(uraniumWaste, amount: 25)
    ],
    output: [
        .init(plutoniumPellet, amount: 30)
    ],
    machine: particleAccelerator,
    duration: 60
)

let encasedPlutoniumCellRecipe1 = Recipe(
    name: "Alternate: Instant Plutonium Cell",
    input: [
        .init(nonFissileUranium, amount: 150),
        .init(aluminumCasing, amount: 20)
    ],
    output: [
        .init(encasedPlutoniumCell, amount: 20)
    ],
    machine: particleAccelerator,
    duration: 120,
    isDefault: false
)

// MARK: - Quantum Technology
let nuclearPastaRecipe = Recipe(
    name: "Nuclear Pasta",
    input: [
        .init(copperPowder, amount: 200),
        .init(pressureConversionCube, amount: 1)
    ],
    output: [
        .init(nuclearPasta, amount: 1)
    ],
    machine: particleAccelerator,
    duration: 120
)

let ParticleAcceleratorRecipes = [
    // Nuclear
    plutoniumPelletRecipe,
    encasedPlutoniumCellRecipe1,
    
    // Quantum Technology
    nuclearPastaRecipe
]
