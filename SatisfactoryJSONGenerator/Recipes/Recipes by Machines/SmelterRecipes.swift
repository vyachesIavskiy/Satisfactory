let ironIngotRecipe = Recipe(
    name: "Iron Ingot",
    input: [
        .init(ironOre, amount: 1)
    ],
    output: [
        .init(ironIngot, amount: 1)
    ],
    machine: smelter,
    duration: 2
)

let copperIngotRecipe = Recipe(
    name: "Copper Ingot",
    input: [
        .init(copperOre, amount: 1)
    ],
    output: [
        .init(copperIngot, amount: 1)
    ],
    machine: smelter,
    duration: 2
)

let cateriumIngotRecipe = Recipe(
    name: "Caterium Ingot",
    input: [
        .init(cateriumOre, amount: 3)
    ],
    output: [
        .init(cateriumIngot, amount: 1)
    ],
    machine: smelter,
    duration: 4
)

let aluminumIngotRecipe1 = Recipe(
    name: "Alternate: Pure Aluminum Ingot",
    input: [
        .init(aluminumScrap, amount: 12)
    ],
    output: [
        .init(aluminumIngot, amount: 3)
    ],
    machine: smelter,
    duration: 5,
    isDefault: false
)

let smelterRecipes = [
    ironIngotRecipe,
    copperIngotRecipe,
    cateriumIngotRecipe,
    aluminumIngotRecipe1
]
