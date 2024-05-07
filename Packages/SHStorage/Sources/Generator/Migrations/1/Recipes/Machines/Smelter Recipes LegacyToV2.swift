
extension LegacyToV2.Recipes {
    // Ingots
    static let ironIngotRecipe = Migration.IDs(old: Legacy.Recipes.ironIngotRecipe, new: V2.Recipes.ironIngotRecipe)
    static let copperIngotRecipe = Migration.IDs(old: Legacy.Recipes.copperIngotRecipe, new: V2.Recipes.copperIngotRecipe)
    static let cateriumIngotRecipe = Migration.IDs(old: Legacy.Recipes.cateriumIngotRecipe, new: V2.Recipes.cateriumIngotRecipe)
    static let aluminumIngotRecipe1 = Migration.IDs(old: Legacy.Recipes.aluminumIngotRecipe1, new: V2.Recipes.aluminumIngotRecipe1)
    
    static let smelterRecipes = [
        ironIngotRecipe,
        copperIngotRecipe,
        cateriumIngotRecipe,
        aluminumIngotRecipe1,
    ]
}
