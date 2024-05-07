extension LegacyToV2.Recipes {
    // Industrial Parts
    static let coolingSystemRecipe = Migration.IDs(old: Legacy.Recipes.coolingSystemRecipe, new: V2.Recipes.coolingSystemRecipe)
    static let coolingSystemRecipe1 = Migration.IDs(old: Legacy.Recipes.coolingSystemRecipe1, new: V2.Recipes.coolingSystemRecipe1)
    static let fusedModularFrameRecipe = Migration.IDs(old: Legacy.Recipes.fusedModularFrameRecipe, new: V2.Recipes.fusedModularFrameRecipe)
    static let fusedModularFrameRecipe1 = Migration.IDs(old: Legacy.Recipes.fusedModularFrameRecipe1, new: V2.Recipes.fusedModularFrameRecipe1)
    static let batteryRecipe = Migration.IDs(old: Legacy.Recipes.batteryRecipe, new: V2.Recipes.batteryRecipe)

    // Fuel
    static let fuelRecipe2 = Migration.IDs(old: Legacy.Recipes.fuelRecipe2, new: V2.Recipes.fuelRecipe2)
    static let turbofuelRecipe2 = Migration.IDs(old: Legacy.Recipes.turbofuelRecipe2, new: V2.Recipes.turbofuelRecipe2)

    // Nuclear
    static let nonFissileUraniumRecipe = Migration.IDs(old: Legacy.Recipes.nonFissileUraniumRecipe, new: V2.Recipes.nonFissileUraniumRecipe)
    static let nonFissileUraniumRecipe1 = Migration.IDs(old: Legacy.Recipes.nonFissileUraniumRecipe1, new: V2.Recipes.nonFissileUraniumRecipe1)
    static let encasedUraniumCellRecipe = Migration.IDs(old: Legacy.Recipes.encasedUraniumCellRecipe, new: V2.Recipes.encasedUraniumCellRecipe)

    // Andvanced Refinement
    static let nitricAcidRecipe = Migration.IDs(old: Legacy.Recipes.nitricAcidRecipe, new: V2.Recipes.nitricAcidRecipe)
    static let aluminumScrapRecipe2 = Migration.IDs(old: Legacy.Recipes.aluminumScrapRecipe2, new: V2.Recipes.aluminumScrapRecipe2)

    static let blenderRecipes = [
        // Industrial parts
        coolingSystemRecipe,
        coolingSystemRecipe1,
        fusedModularFrameRecipe,
        fusedModularFrameRecipe1,
        batteryRecipe,
        
        // Fuel
        fuelRecipe2,
        turbofuelRecipe2,
        
        // Nuclear
        nonFissileUraniumRecipe,
        nonFissileUraniumRecipe1,
        encasedUraniumCellRecipe,
        
        // Advanced Refinement
        nitricAcidRecipe,
        aluminumScrapRecipe2
    ]
}
