import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        input: Ingredient,
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true,
        manuallyCraftable: Bool = true
    ) {
        self.init(
            id: id,
            inputs: [input],
            output: output,
            byproducts: [],
            machine: V2.Buildings.smelter,
            manualCrafting: (isDefault && !manuallyCraftable) ? [V2.Buildings.craftBench] : [],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Ingots
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
    
    static let aluminumIngotRecipe1 = Recipe.Static(
        id: "recipe-altername-pure-aluminum-ingot",
        input: Recipe.Static.Ingredient(V2.Parts.aluminumScrap, amount: 2),
        output: Recipe.Static.Ingredient(V2.Parts.aluminumIngot, amount: 1),
        duration: 2,
        isDefault: false
    )
    
    // MARK: - FICSMAS
    static let redFicsmasOrnamentRecipe = Recipe.Static(
        id: "recipe-red-ficsmas-ornament",
        input: Recipe.Static.Ingredient(V2.Parts.ficsmasGift, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.redFicsmasOrnament, amount: 1),
        duration: 12,
        manuallyCraftable: false
    )
    
    static let blueFicsmasOrnamentRecipe = Recipe.Static(
        id: "recipe-blue-ficsmas-ornament",
        input: Recipe.Static.Ingredient(V2.Parts.ficsmasGift, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.blueFicsmasOrnament, amount: 2),
        duration: 12,
        manuallyCraftable: false
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
