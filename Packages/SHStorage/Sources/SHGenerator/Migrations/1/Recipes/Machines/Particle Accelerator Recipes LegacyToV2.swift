
extension LegacyToV2.Recipes {
    // MARK: - Space Elevator
    static let nuclearPastaRecipe = Migration.IDs(old: Legacy.Recipes.nuclearPastaRecipe, new: V2.Recipes.nuclearPastaRecipe)
    
    // MARK: - Nuclear
    static let plutoniumPelletRecipe = Migration.IDs(old: Legacy.Recipes.plutoniumPelletRecipe, new: V2.Recipes.plutoniumPelletRecipe)
    static let instantPlutoniumCellRecipe = Migration.IDs(old: Legacy.Recipes.encasedPlutoniumCellRecipe1, new: V2.Recipes.instantPlutoniumCellRecipe)

    static let particleAcceleratorRecipes = [
        // Space Elevator
        nuclearPastaRecipe,
        
        // Nuclear
        plutoniumPelletRecipe,
        instantPlutoniumCellRecipe,
    ]
}
