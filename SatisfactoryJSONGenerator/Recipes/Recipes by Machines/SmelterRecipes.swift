let ironIngotRecipe = Recipe(input: [
    .init(ironOre, amount: 1)
    ], output: [
        .init(ironIngot, amount: 1)
], machine: smelter, duration: 2)

let copperIngotRecipe = Recipe(input: [
    .init(copperOre, amount: 1)
    ], output: [
        .init(copperIngot, amount: 1)
], machine: smelter, duration: 2)

let cateriumIngotRecipe = Recipe(input: [
    .init(cateriumOre, amount: 3)
    ], output: [
        .init(cateriumIngot, amount: 1)
], machine: smelter, duration: 4)

let aluminumIngotRecipe1 = Recipe(input: [
    .init(aluminumScrap, amount: 12)
    ], output: [
        .init(aluminumIngot, amount: 3)
], machine: smelter, duration: 5, isDefault: false)

let smelterRecipes = [
    ironIngotRecipe,
    copperIngotRecipe,
    cateriumIngotRecipe,
    aluminumIngotRecipe1
]
