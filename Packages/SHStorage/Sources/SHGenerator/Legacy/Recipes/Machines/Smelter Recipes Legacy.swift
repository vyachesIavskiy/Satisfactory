import SHModels
import SHStaticModels

private extension Recipe.Static.Legacy {
    init(
        id: String,
        name: String,
        input: Ingredient,
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            name: name,
            input: [input],
            output: [output],
            machines: [Legacy.Buildings.smelter.id],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension Legacy.Recipes {
    // Ingots
    static let ironIngotRecipe = Recipe.Static.Legacy(
        id: "iron-ingot",
        name: "Iron Ingot",
        input: .init(Legacy.Parts.ironOre, amount: 1),
        output: .init(Legacy.Parts.ironIngot, amount: 1),
        duration: 2
    )
    
    static let copperIngotRecipe = Recipe.Static.Legacy(
        id: "copper-ingot",
        name: "Copper Ingot",
        input: .init(Legacy.Parts.copperOre, amount: 1),
        output: .init(Legacy.Parts.copperIngot, amount: 1),
        duration: 2
    )
    
    static let cateriumIngotRecipe = Recipe.Static.Legacy(
        id: "caterium-ingot",
        name: "Caterium Ingot",
        input: .init(Legacy.Parts.cateriumOre, amount: 3),
        output: .init(Legacy.Parts.cateriumIngot, amount: 1),
        duration: 4
    )
    
    static let aluminumIngotRecipe1 = Recipe.Static.Legacy(
        id: "alternate-pure-aluminum-ingot",
        name: "Alternate: Pure Aluminum Ingot",
        input: .init(Legacy.Parts.aluminumScrap, amount: 2),
        output: .init(Legacy.Parts.aluminumIngot, amount: 1),
        duration: 2,
        isDefault: false
    )
    
    static let smelterRecipes = [
        ironIngotRecipe,
        copperIngotRecipe,
        cateriumIngotRecipe,
        aluminumIngotRecipe1,
    ]
}
