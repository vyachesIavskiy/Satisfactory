private extension Recipe {
    init(
        name: String,
        input: [RecipePart],
        output: [RecipePart],
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            name: name,
            input: input,
            output: output,
            machines: [smelter],
            duration: duration,
            isDefault: isDefault
        )
    }
}

// MARK: - Ingots
let ironIngotRecipe = Recipe(
    name: "Iron Ingot",
    input: [
        .init(ironOre, amount: 1)
    ],
    output: [
        .init(ironIngot, amount: 1)
    ],
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
    duration: 4
)

let aluminumIngotRecipe1 = Recipe(
    name: "Alternate: Pure Aluminum Ingot",
    input: [
        .init(aluminumScrap, amount: 2)
    ],
    output: [
        .init(aluminumIngot, amount: 1)
    ],
    duration: 2,
    isDefault: false
)

// MARK: - FICSMAS
let redFicsmasOrnamentRecipe = Recipe(
    name: "Red FICSMAS Ornament",
    input: [
        .init(ficsmasGift, amount: 1)
    ],
    output: [
        .init(redFicsmasOrnament, amount: 1)
    ],
    duration: 12
)

let blueFicsmasOrnamentRecipe = Recipe(
    name: "Blue FICSMAS Ornament",
    input: [
        .init(ficsmasGift, amount: 1)
    ],
    output: [
        .init(blueFicsmasOrnament, amount: 2)
    ],
    duration: 12
)

let SmelterRecipes = [
    // Ingots
    ironIngotRecipe,
    copperIngotRecipe,
    cateriumIngotRecipe,
    aluminumIngotRecipe1,
    
    // FICSMAS
    redFicsmasOrnamentRecipe,
    blueFicsmasOrnamentRecipe
]
