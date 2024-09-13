
extension LegacyToV2.Recipes {
    // MARK: - Ingots
    static let steelIngotRecipe = Migration.IDs(old: Legacy.Recipes.steelIngotRecipe, new: V2.Recipes.steelIngotRecipe)
    static let solidSteelIngotRecipe = Migration.IDs(old: Legacy.Recipes.steelIngotRecipe1, new: V2.Recipes.solidSteelIngotRecipe)
    static let compactedSteelIngotRecipe = Migration.IDs(old: Legacy.Recipes.steelIngotRecipe2, new: V2.Recipes.compactedSteelIngotRecipe)
    static let cokeSteelIngotRecipe = Migration.IDs(old: Legacy.Recipes.steelIngotRecipe3, new: V2.Recipes.cokeSteelIngotRecipe)
    static let ironAlloyIngotRecipe = Migration.IDs(old: Legacy.Recipes.ironIngotRecipe1, new: V2.Recipes.ironAlloyIngotRecipe)
    static let copperAlloyIngotRecipe = Migration.IDs(old: Legacy.Recipes.copperIngotRecipe1, new: V2.Recipes.copperAlloyIngotRecipe)
    static let aluminumIngotRecipe = Migration.IDs(old: Legacy.Recipes.aluminumIngotRecipe, new: V2.Recipes.aluminumIngotRecipe)
    
    static let foundryRecipes = [
        // Ingots
        steelIngotRecipe,
        solidSteelIngotRecipe,
        compactedSteelIngotRecipe,
        cokeSteelIngotRecipe,
        ironAlloyIngotRecipe,
        copperAlloyIngotRecipe,
        aluminumIngotRecipe,
    ]
}
