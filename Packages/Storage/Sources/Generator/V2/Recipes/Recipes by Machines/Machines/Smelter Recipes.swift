import StaticModels

private extension Recipe {
    init(
        id: String,
        input: Ingredient,
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: [input],
            output: output,
            byproducts: [],
            machines: [V2.Buildings.smelter, V2.Buildings.craftBench],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Ingots
    static let ironIngotRecipe = Recipe(
        id: "recipe-iron-ingot",
        input: Recipe.Ingredient(V2.Parts.ironOre, amount: 1),
        output: Recipe.Ingredient(V2.Parts.ironIngot, amount: 1),
        duration: 2
    )
    
    static let copperIngotRecipe = Recipe(
        id: "recipe-copper-ingot",
        input: Recipe.Ingredient(V2.Parts.copperOre, amount: 1),
        output: Recipe.Ingredient(V2.Parts.copperIngot, amount: 1),
        duration: 2
    )
    
    static let cateriumIngotRecipe = Recipe(
        id: "recipe-caterium-ingot",
        input: Recipe.Ingredient(V2.Parts.cateriumOre, amount: 3),
        output: Recipe.Ingredient(V2.Parts.cateriumIngot, amount: 1),
        duration: 4
    )
    
    static let aluminumIngotRecipe1 = Recipe(
        id: "recipe-altername-pure-aluminum-ingot",
        input: Recipe.Ingredient(V2.Parts.aluminumScrap, amount: 2),
        output: Recipe.Ingredient(V2.Parts.aluminumIngot, amount: 1),
        duration: 2,
        isDefault: false
    )
    
    // MARK: - FICSMAS
    static let redFicsmasOrnamentRecipe = Recipe(
        id: "recipe-red-ficsmas-ornament",
        input: Recipe.Ingredient(V2.Parts.ficsmasGift, amount: 1),
        output: Recipe.Ingredient(V2.Parts.redFicsmasOrnament, amount: 1),
        duration: 12
    )
    
    static let blueFicsmasOrnamentRecipe = Recipe(
        id: "recipe-blue-ficsmas-ornament",
        input: Recipe.Ingredient(V2.Parts.ficsmasGift, amount: 1),
        output: Recipe.Ingredient(V2.Parts.blueFicsmasOrnament, amount: 2),
        duration: 12
    )
    
    static let smelterRecipes = [
        ironIngotRecipe,
        copperIngotRecipe,
        cateriumIngotRecipe,
        aluminumIngotRecipe1,
        redFicsmasOrnamentRecipe,
        blueFicsmasOrnamentRecipe
    ]
}
