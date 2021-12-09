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
            machines: [foundry],
            duration: duration,
            isDefault: isDefault
        )
    }
}

// MARK: - Ingots
let steelIngotRecipe = Recipe(
    name: "Steel Ingot",
    input: [
        .init(ironOre, amount: 3),
        .init(coal, amount: 3)
    ],
    output: [
        .init(steelIngot, amount: 3)
    ],
    duration: 4
)

let steelIngotRecipe1 = Recipe(
    name: "Alternate: Solid Steel Ingot",
    input: [
        .init(ironIngot, amount: 2),
        .init(coal, amount: 2)
    ],
    output: [
        .init(steelIngot, amount: 3)
    ],
    duration: 3,
    isDefault: false
)

let steelIngotRecipe2 = Recipe(
    name: "Alternate: Compacted Steel Ingot",
    input: [
        .init(ironOre, amount: 6),
        .init(compactedCoal, amount: 3)
    ],
    output: [
        .init(steelIngot, amount: 10)
    ],
    duration: 16,
    isDefault: false
)

let steelIngotRecipe3 = Recipe(
    name: "Alternate: Coke Steel Ingot",
    input: [
        .init(ironOre, amount: 15),
        .init(petroleumCoke, amount: 15)
    ],
    output: [
        .init(steelIngot, amount: 20)
    ],
    duration: 12,
    isDefault: false
)

let ironIngotRecipe1 = Recipe(
    name: "Alternate: Iron Alloy Ingot",
    input: [
        .init(ironOre, amount: 2),
        .init(copperOre, amount: 2)
    ],
    output: [
        .init(ironIngot, amount: 5)
    ],
    duration: 6,
    isDefault: false
)

let copperIngotRecipe1 = Recipe(
    name: "Alternate: Copper Alloy Ingot",
    input: [
        .init(copperOre, amount: 10),
        .init(ironOre, amount: 5)
    ],
    output: [
        .init(copperIngot, amount: 20)
    ],
    duration: 12,
    isDefault: false
)

let aluminumIngotRecipe = Recipe(
    name: "Aluminum Ingot",
    input: [
        .init(aluminumScrap, amount: 6),
        .init(silica, amount: 5)
    ],
    output: [
        .init(aluminumIngot, amount: 4)
    ],
    duration: 4
)

// MARK: - FICSMAS
let copperFicsmasOrnamentRecipe = Recipe(
    name: "Copper FICSMAS Ornament",
    input: [
        .init(redFicsmasOrnament, amount: 2),
        .init(copperIngot, amount: 2)
    ],
    output: [
        .init(copperFicsmasOrnament, amount: 1)
    ],
    duration: 12
)

let ironFicsmasOrnamentRecipe = Recipe(
    name: "Iron FICSMAS Ornament",
    input: [
        .init(blueFicsmasOrnament, amount: 3),
        .init(ironIngot, amount: 3)
    ],
    output: [
        .init(ironFicsmasOrnament, amount: 1)
    ],
    duration: 12
)

let FoundryRecipes = [
    // Ingots
    steelIngotRecipe,
    steelIngotRecipe1,
    steelIngotRecipe2,
    steelIngotRecipe3,
    ironIngotRecipe1,
    copperIngotRecipe1,
    aluminumIngotRecipe,
    
    // FICSMAS
    copperFicsmasOrnamentRecipe,
    ironFicsmasOrnamentRecipe
]
