import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        input: Ingredient,
        output: Ingredient,
        duration: Double,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: [input],
            output: output,
            byproducts: [],
            machine: V2.Buildings.smelter,
            duration: duration,
            powerConsumption: PowerConsumption(4),
            isDefault: isDefault
        )
    }
}

// MARK: - Ingots
extension V2.Recipes {
    static let ironIngotRecipe = Recipe.Static(
        id: "recipe-iron-ingot",
        input: Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 1),
        duration: 2
    )
    
    static let copperIngotRecipe = Recipe.Static(
        id: "recipe-copper-ingot",
        input: Recipe.Static.Ingredient(V2.Parts.copperOre, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 1),
        duration: 2
    )
    
    static let cateriumIngotRecipe = Recipe.Static(
        id: "recipe-caterium-ingot",
        input: Recipe.Static.Ingredient(V2.Parts.cateriumOre, amount: 3),
        output: Recipe.Static.Ingredient(V2.Parts.cateriumIngot, amount: 1),
        duration: 4
    )
    
    static let pureAluminumIngotRecipe = Recipe.Static(
        id: "recipe-altername-pure-aluminum-ingot",
        input: Recipe.Static.Ingredient(V2.Parts.aluminumScrap, amount: 2),
        output: Recipe.Static.Ingredient(V2.Parts.aluminumIngot, amount: 1),
        duration: 2,
        isDefault: false
    )
    
    private static let ingotsRecipes = [
        ironIngotRecipe,
        copperIngotRecipe,
        cateriumIngotRecipe,
        pureAluminumIngotRecipe,
    ]
}

// MARK: - FICSMAS
extension V2.Recipes {
    static let redFicsmasOrnamentRecipe = Recipe.Static(
        id: "recipe-red-ficsmas-ornament",
        input: Recipe.Static.Ingredient(V2.Parts.ficsmasGift, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.redFicsmasOrnament, amount: 1),
        duration: 12
    )
    
    static let blueFicsmasOrnamentRecipe = Recipe.Static(
        id: "recipe-blue-ficsmas-ornament",
        input: Recipe.Static.Ingredient(V2.Parts.ficsmasGift, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.blueFicsmasOrnament, amount: 2),
        duration: 12
    )
    
    private static let ficsmasRecipes = [
        redFicsmasOrnamentRecipe,
        blueFicsmasOrnamentRecipe
    ]
}

// MARK: - Smelter recipes
extension V2.Recipes {
    static let smelterRecipes =
    ingotsRecipes +
    ficsmasRecipes
}
