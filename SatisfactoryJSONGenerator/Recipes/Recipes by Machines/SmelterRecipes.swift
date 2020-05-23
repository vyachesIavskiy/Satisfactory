let ironIngotRecipe = Recipe(input: [
    .init(ironOre, amount: 30)
    ], output: [
        .init(ironIngot, amount: 30)
], machine: smelter)

let copperIngotRecipe = Recipe(input: [
    .init(copperOre, amount: 30)
    ], output: [
        .init(copperIngot, amount: 30)
], machine: smelter)

let cateriumIngotRecipe = Recipe(input: [
    .init(cateriumOre, amount: 45)
    ], output: [
        .init(cateriumIngot, amount: 15)
], machine: smelter)

let aluminumIngotRecipe1 = Recipe(input: [
    .init(aluminumScrap, amount: 144)
    ], output: [
        .init(aluminumIngot, amount: 36)
], machine: smelter, isDefault: false)

let smelterRecipes = [
    ironIngotRecipe,
    copperIngotRecipe,
    cateriumIngotRecipe,
    aluminumIngotRecipe1
]
