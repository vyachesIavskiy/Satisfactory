let steelIngotRecipe = Recipe(input: [
    .init(ironOre, amount: 45),
    .init(coal, amount: 45)
    ], output: [
        .init(steelIngot, amount: 45)
], machine: foundry)

let ironIngotRecipe1 = Recipe(input: [
    .init(ironOre, amount: 20),
    .init(copperOre, amount: 20)
    ], output: [
        .init(ironIngot, amount: 50)
], machine: foundry, isDefault: false)

let copperIngotRecipe1 = Recipe(input: [
    .init(copperOre, amount: 50),
    .init(ironOre, amount: 25)
    ], output: [
        .init(copperIngot, amount: 100)
], machine: foundry, isDefault: false)

let steelIngotRecipe1 = Recipe(input: [
    .init(ironIngot, amount: 40),
    .init(coal, amount: 40)
    ], output: [
        .init(steelIngot, amount: 60)
], machine: foundry, isDefault: false)

let steelIngotRecipe2 = Recipe(input: [
    .init(ironOre, amount: 22.5),
    .init(compactedCoal, amount: 11.25)
    ], output: [
        .init(steelIngot, amount: 37.5)
], machine: foundry, isDefault: false)

let steelIngotRecipe3 = Recipe(input: [
    .init(ironOre, amount: 75),
    .init(petroleumCoke, amount: 75)
    ], output: [
        .init(steelIngot, amount: 100)
], machine: foundry, isDefault: false)

let aluminumIngotRecipe = Recipe(input: [
    .init(aluminumScrap, amount: 240),
    .init(silica, amount: 140)
    ], output: [
        .init(aluminumIngot, amount: 80)
], machine: foundry)

let foundryRecipes = [
    steelIngotRecipe,
    ironIngotRecipe1,
    copperIngotRecipe1,
    steelIngotRecipe1,
    steelIngotRecipe2,
    steelIngotRecipe3,
    aluminumIngotRecipe
]
