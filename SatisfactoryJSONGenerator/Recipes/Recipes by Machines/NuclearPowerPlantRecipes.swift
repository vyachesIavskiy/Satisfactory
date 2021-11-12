// MARK: - Nuclear Power Plant
let uraniumWasteRecipe = Recipe(
    name: "Uranium Waste",
    input: [
        .init(uraniumFuelRod, amount: 1)
    ],
    output: [
        .init(uraniumWaste, amount: 50)
    ],
    machines: [
        nuclearPowerPlant
    ],
    duration: 300
)

let plutoniumWasteRecipe = Recipe(
    name: "Plutonium Waste",
    input: [
        .init(plutoniumFuelRod, amount: 1)
    ],
    output: [
        .init(plutoniumWaste, amount: 10)
    ],
    machines: [
        nuclearPowerPlant
    ],
    duration: 600
)

let NuclearPowerPlantRecipes = [
    uraniumWasteRecipe,
    plutoniumWasteRecipe
]
