import StaticModels

private extension Recipe {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            machines: isDefault ? [V2.Buildings.foundry, V2.Buildings.craftBench] : [V2.Buildings.foundry],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Ingots
    static let steelIngotRecipe = Recipe(
        id: "recipe-steel-ingot",
        inputs: [
            Recipe.Ingredient(V2.Parts.ironOre, amount: 3),
            Recipe.Ingredient(V2.Parts.coal, amount: 3)
        ],
        output: Recipe.Ingredient(V2.Parts.steelIngot, amount: 3),
        duration: 4
    )
    
    static let steelIngotRecipe1 = Recipe(
        id: "recipe-alternate-solid-steel-ingot",
        inputs: [
            Recipe.Ingredient(V2.Parts.ironIngot, amount: 2),
            Recipe.Ingredient(V2.Parts.coal, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.steelIngot, amount: 3),
        duration: 3,
        isDefault: false
    )
    
    static let steelIngotRecipe2 = Recipe(
        id: "recipe-alternate-compacted-steel-ingot",
        inputs: [
            Recipe.Ingredient(V2.Parts.ironOre, amount: 6),
            Recipe.Ingredient(V2.Parts.compactedCoal, amount: 3)
        ],
        output: Recipe.Ingredient(V2.Parts.steelIngot, amount: 10),
        duration: 16,
        isDefault: false
    )
    
    static let steelIngotRecipe3 = Recipe(
        id: "recipe-alternate-coke-steel-ingot",
        inputs: [
            Recipe.Ingredient(V2.Parts.ironOre, amount: 15),
            Recipe.Ingredient(V2.Parts.petroleumCoke, amount: 15)
        ],
        output: Recipe.Ingredient(V2.Parts.steelIngot, amount: 20),
        duration: 12,
        isDefault: false
    )
    
    static let ironIngotRecipe1 = Recipe(
        id: "recipe-alternate-iron-alloy-ingot",
        inputs: [
            Recipe.Ingredient(V2.Parts.ironOre, amount: 2),
            Recipe.Ingredient(V2.Parts.copperOre, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.ironIngot, amount: 5),
        duration: 6,
        isDefault: false
    )
    
    static let copperIngotRecipe1 = Recipe(
        id: "recipe-alternate-copper-alloy-ingot",
        inputs: [
            Recipe.Ingredient(V2.Parts.copperOre, amount: 10),
            Recipe.Ingredient(V2.Parts.ironOre, amount: 5)
        ],
        output: Recipe.Ingredient(V2.Parts.copperIngot, amount: 20),
        duration: 12,
        isDefault: false
    )
    
    static let aluminumIngotRecipe = Recipe(
        id: "recipe-aluminum-ingot",
        inputs: [
            Recipe.Ingredient(V2.Parts.aluminumScrap, amount: 6),
            Recipe.Ingredient(V2.Parts.silica, amount: 5)
        ],
        output: Recipe.Ingredient(V2.Parts.aluminumIngot, amount: 4),
        duration: 4
    )
    
    // MARK: - FICSMAS
    static let copperFicsmasOrnamentRecipe = Recipe(
        id: "recipe-copprt-ficsmas-ornament",
        inputs: [
            Recipe.Ingredient(V2.Parts.redFicsmasOrnament, amount: 2),
            Recipe.Ingredient(V2.Parts.copperIngot, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.copperFicsmasOrnament, amount: 1),
        duration: 12
    )
    
    static let ironFicsmasOrnamentRecipe = Recipe(
        id: "recipe-iron-ficsmas-ornament",
        inputs: [
            Recipe.Ingredient(V2.Parts.blueFicsmasOrnament, amount: 3),
            Recipe.Ingredient(V2.Parts.ironIngot, amount: 3)
        ],
        output: Recipe.Ingredient(V2.Parts.ironFicsmasOrnament, amount: 1),
        duration: 12
    )
    
    static let foundryRecipes = [
        steelIngotRecipe,
        steelIngotRecipe1,
        steelIngotRecipe2,
        steelIngotRecipe3,
        ironIngotRecipe1,
        copperIngotRecipe1,
        aluminumIngotRecipe,
        copperFicsmasOrnamentRecipe,
        ironFicsmasOrnamentRecipe
    ]
}
