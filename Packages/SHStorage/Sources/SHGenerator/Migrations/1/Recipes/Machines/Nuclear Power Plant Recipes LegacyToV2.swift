
extension LegacyToV2.Recipes {
    // Nuclear Power Plant
    static let uraniumWasteRecipe = Migration.IDs(old: Legacy.Recipes.uraniumWasteRecipe, new: V2.Recipes.uraniumWasteRecipe)
    static let plutoniumWasteRecipe = Migration.IDs(old: Legacy.Recipes.plutoniumWasteRecipe, new: V2.Recipes.plutoniumWasteRecipe)

    static let nuclearPowerPlantRecipes = [
        uraniumWasteRecipe,
        plutoniumWasteRecipe
    ]
}
