
extension LegacyToV2.Recipes {
    // Nuclear
    static let plutoniumPelletRecipe = Migration.IDs(old: Legacy.Recipes.plutoniumPelletRecipe, new: V2.Recipes.plutoniumPelletRecipe)
    static let encasedPlutoniumCellRecipe1 = Migration.IDs(old: Legacy.Recipes.encasedPlutoniumCellRecipe1, new: V2.Recipes.encasedPlutoniumCellRecipe1)

    // Quantum Technology
    static let nuclearPastaRecipe = Migration.IDs(old: Legacy.Recipes.nuclearPastaRecipe, new: V2.Recipes.nuclearPastaRecipe)

    static let particleAcceleratorRecipes = [
        // Nuclear
        plutoniumPelletRecipe,
        encasedPlutoniumCellRecipe1,
        
        // Quantum Technology
        nuclearPastaRecipe
    ]
}
