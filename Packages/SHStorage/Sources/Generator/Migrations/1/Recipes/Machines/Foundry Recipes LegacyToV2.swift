
extension LegacyToV2.Recipes {
    // Ingots
    static let steelIngotRecipe = Migration.IDs(old: Legacy.Recipes.steelIngotRecipe, new: V2.Recipes.steelIngotRecipe)
    static let steelIngotRecipe1 = Migration.IDs(old: Legacy.Recipes.steelIngotRecipe1, new: V2.Recipes.steelIngotRecipe1)
    static let steelIngotRecipe2 = Migration.IDs(old: Legacy.Recipes.steelIngotRecipe2, new: V2.Recipes.steelIngotRecipe2)
    static let steelIngotRecipe3 = Migration.IDs(old: Legacy.Recipes.steelIngotRecipe3, new: V2.Recipes.steelIngotRecipe3)
    static let ironIngotRecipe1 = Migration.IDs(old: Legacy.Recipes.ironIngotRecipe1, new: V2.Recipes.ironIngotRecipe1)
    static let copperIngotRecipe1 = Migration.IDs(old: Legacy.Recipes.copperIngotRecipe1, new: V2.Recipes.copperIngotRecipe1)
    static let aluminumIngotRecipe = Migration.IDs(old: Legacy.Recipes.aluminumIngotRecipe, new: V2.Recipes.aluminumIngotRecipe)
    
    static let foundryRecipes = [
        // Ingots
        steelIngotRecipe,
        steelIngotRecipe1,
        steelIngotRecipe2,
        steelIngotRecipe3,
        ironIngotRecipe1,
        copperIngotRecipe1,
        aluminumIngotRecipe,
    ]
}
