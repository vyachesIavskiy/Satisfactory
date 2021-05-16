// MARK: - Packaging
let packagedWaterRecipe = Recipe(
    name: "Packaged Water",
    input: [
        .init(water, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    output: [
        .init(packagedWater, amount: 2)
    ],
    machine: packager,
    duration: 2
)

let packagedOilRecipe = Recipe(
    name: "Packaged Oil",
    input: [
        .init(crudeOil, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    output: [
        .init(packagedOil, amount: 2)
    ],
    machine: packager,
    duration: 4
)

let packagedHeavyOilResidueRecipe = Recipe(
    name: "Packaged Heavy Oil Residue",
    input: [
        .init(heavyOilResidue, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    output: [
        .init(packagedHeavyOilResidue, amount: 2)
    ],
    machine: packager,
    duration: 4
)

let packagedLiquidBiofuelRecipe = Recipe(
    name: "Packaged Liquid Biofuel",
    input: [
        .init(liquidBiofuel, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    output: [
        .init(packagedLiquidBiofuel, amount: 2)
    ],
    machine: packager,
    duration: 3
)

let packagedFuelRecipe = Recipe(
    name: "Packaged Fuel",
    input: [
        .init(fuel, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    output: [
        .init(packagedFuel, amount: 2)
    ],
    machine: packager,
    duration: 3
)

let packagedTurbofuelRecipe = Recipe(
    name: "Packaged Turbofuel",
    input: [
        .init(turbofuel, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    output: [
        .init(packagedTurbofuel, amount: 2)
    ],
    machine: packager,
    duration: 6
)

let packagedAluminaSolutionRecipe = Recipe(
    name: "Packaged Alumina Solution",
    input: [
        .init(aluminaSolution, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    output: [
        .init(packagedAluminaSolution, amount: 2)
    ],
    machine: packager,
    duration: 1
)

let packagedSulfuricAcidRecipe = Recipe(
    name: "Packaged Sulfuric Acid",
    input: [
        .init(sulfuricAcid, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    output: [
        .init(packagedSulfuricAcid, amount: 2)
    ],
    machine: packager,
    duration: 3
)

let packagedNitrogenGasRecipe = Recipe(
    name: "Packaged Nitrogen Gas",
    input: [
        .init(nitrogenGas, amount: 4),
        .init(emptyFluidTank, amount: 1)
    ],
    output: [
        .init(packagedNitrogenGas, amount: 1)
    ],
    machine: packager,
    duration: 1
)

let packagedNitricAcidRecipe = Recipe(
    name: "Packaged Nitric Acid",
    input: [
        .init(nitricAcid, amount: 1),
        .init(emptyFluidTank, amount: 1)
    ],
    output: [
        .init(packagedNitricAcid, amount: 1)
    ],
    machine: packager,
    duration: 2
)

// MARK: - Unpackaging
let unpackagedWaterRecipe = Recipe(
    name: "Unpackaged Water",
    input: [
        .init(packagedWater, amount: 2)
    ],
    output: [
        .init(water, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    machine: packager,
    duration: 1
)

let unpackagedOilRecipe = Recipe(
    name: "Unpackaged Oil",
    input: [
        .init(packagedOil, amount: 2)
    ],
    output: [
        .init(crudeOil, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    machine: packager,
    duration: 2
)

let unpackagedHeavyOilResidueRecipe = Recipe(
    name: "Unpackaged Heavy Oil Residue",
    input: [
        .init(packagedHeavyOilResidue, amount: 2)
    ],
    output: [
        .init(heavyOilResidue, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    machine: packager,
    duration: 6
)

let unpackagedLiquidBiofuelRecipe = Recipe(
    name: "Unpackaged Liquid Biofuel",
    input: [
        .init(packagedLiquidBiofuel, amount: 2)
    ],
    output: [
        .init(liquidBiofuel, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    machine: packager,
    duration: 2
)

let unpackagedFuelRecipe = Recipe(
    name: "Unpackaged Fuel",
    input: [
        .init(packagedFuel, amount: 2)
    ],
    output: [
        .init(fuel, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    machine: packager,
    duration: 2
)

let unpackagedTurbofuelRecipe = Recipe(
    name: "Unpackaged Turbofuel",
    input: [
        .init(packagedTurbofuel, amount: 2)
    ],
    output: [
        .init(turbofuel, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    machine: packager,
    duration: 6
)

let unpackagedAluminaSolutionRecipe = Recipe(
    name: "Unpackaged Alumina Solution",
    input: [
        .init(packagedAluminaSolution, amount: 2)
    ],
    output: [
        .init(aluminaSolution, amount: 2),
        .init(emptyCanister, amount: 2)
    ],
    machine: packager,
    duration: 1
)

let unpackagedSulfuricAcidRecipe = Recipe(
    name: "Unpackaged Sulfuric Acid",
    input: [
        .init(packagedSulfuricAcid, amount: 1)
    ],
    output: [
        .init(sulfuricAcid, amount: 1),
        .init(emptyCanister, amount: 1)
    ],
    machine: packager,
    duration: 1
)

let unpackagedNitrogenGasRecipe = Recipe(
    name: "Unpackaged Nitrogen Gas",
    input: [
        .init(packagedNitrogenGas, amount: 1)
    ],
    output: [
        .init(nitrogenGas, amount: 4),
        .init(emptyFluidTank, amount: 1)
    ],
    machine: packager,
    duration: 1
)

let unpackagedNitricAcidRecipe = Recipe(
    name: "Unpackaged Nitric Acid",
    input: [
        .init(packagedNitricAcid, amount: 1)
    ],
    output: [
        .init(nitricAcid, amount: 1),
        .init(emptyFluidTank, amount: 1)
    ],
    machine: packager,
    duration: 3
)

let PackagerRecipes = [
    // Packaging
    packagedWaterRecipe,
    packagedOilRecipe,
    packagedHeavyOilResidueRecipe,
    packagedLiquidBiofuelRecipe,
    packagedFuelRecipe,
    packagedTurbofuelRecipe,
    packagedAluminaSolutionRecipe,
    packagedSulfuricAcidRecipe,
    packagedNitrogenGasRecipe,
    packagedNitricAcidRecipe,
    
    // Unpackaging
    unpackagedWaterRecipe,
    unpackagedOilRecipe,
    unpackagedHeavyOilResidueRecipe,
    unpackagedLiquidBiofuelRecipe,
    unpackagedFuelRecipe,
    unpackagedTurbofuelRecipe,
    unpackagedAluminaSolutionRecipe,
    unpackagedSulfuricAcidRecipe,
    unpackagedNitrogenGasRecipe,
    unpackagedNitricAcidRecipe
]
