import SHModels
import SHStaticModels

private extension Recipe.Static.Legacy {
    init(
        id: String,
        output: Ingredient,
        input: Ingredient
    ) {
        self.init(
            id: id,
            output: [output],
            input: [input]
        )
    }
}

extension Legacy.Recipes {
    // Ingots
    static let ironIngotRecipe = Recipe.Static.Legacy(
        id: "iron-ingot",
        output: .init(Legacy.Parts.ironIngot),
        input: .init(Legacy.Parts.ironOre)
    )
    
    static let copperIngotRecipe = Recipe.Static.Legacy(
        id: "copper-ingot",
        output: .init(Legacy.Parts.copperIngot),
        input: .init(Legacy.Parts.copperOre)
    )
    
    static let cateriumIngotRecipe = Recipe.Static.Legacy(
        id: "caterium-ingot",
        output: .init(Legacy.Parts.cateriumIngot),
        input: .init(Legacy.Parts.cateriumOre)
    )
    
    static let aluminumIngotRecipe1 = Recipe.Static.Legacy(
        id: "alternate-pure-aluminum-ingot",
        output: .init(Legacy.Parts.aluminumIngot),
        input: .init(Legacy.Parts.aluminumScrap)
    )
    
    static let smelterRecipes = [
        ironIngotRecipe,
        copperIngotRecipe,
        cateriumIngotRecipe,
        aluminumIngotRecipe1,
    ]
}
