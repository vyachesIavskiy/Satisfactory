extension LegacyToV2.Recipes {
    // MARK: - Andvanced Refinement
    static let nitricAcidRecipe = Migration.IDs(old: Legacy.Recipes.nitricAcidRecipe, new: V2.Recipes.nitricAcidRecipe)
    static let instantScrapRecipe = Migration.IDs(old: Legacy.Recipes.aluminumScrapRecipe2, new: V2.Recipes.instantScrapRecipe)
    
    // MARK: - Fuel
    static let dilutedFuelRecipe = Migration.IDs(old: Legacy.Recipes.fuelRecipe2, new: V2.Recipes.dilutedFuelRecipe)
    static let turboBlendFuelRecipe = Migration.IDs(old: Legacy.Recipes.turbofuelRecipe2, new: V2.Recipes.turboBlendFuelRecipe)
    
    // MARK: - Industrial Parts
    static let coolingSystemRecipe = Migration.IDs(old: Legacy.Recipes.coolingSystemRecipe, new: V2.Recipes.coolingSystemRecipe)
    static let coolingDeviceRecipe = Migration.IDs(old: Legacy.Recipes.coolingSystemRecipe1, new: V2.Recipes.coolingDeviceRecipe)
    static let fusedModularFrameRecipe = Migration.IDs(old: Legacy.Recipes.fusedModularFrameRecipe, new: V2.Recipes.fusedModularFrameRecipe)
    static let heatFusedModularFrameRecipe = Migration.IDs(old: Legacy.Recipes.fusedModularFrameRecipe1, new: V2.Recipes.heatFusedModularFrameRecipe)
    static let batteryRecipe = Migration.IDs(old: Legacy.Recipes.batteryRecipe, new: V2.Recipes.batteryRecipe)

    // MARK: - Nuclear
    static let nonFissileUraniumRecipe = Migration.IDs(old: Legacy.Recipes.nonFissileUraniumRecipe, new: V2.Recipes.nonFissileUraniumRecipe)
    static let fertileUraniumRecipe = Migration.IDs(old: Legacy.Recipes.nonFissileUraniumRecipe1, new: V2.Recipes.fertileUraniumRecipe)
    static let encasedUraniumCellRecipe = Migration.IDs(old: Legacy.Recipes.encasedUraniumCellRecipe, new: V2.Recipes.encasedUraniumCellRecipe)

    static let blenderRecipes = [
        // Advanced Refinement
        nitricAcidRecipe,
        instantScrapRecipe,
        
        // Fuel
        dilutedFuelRecipe,
        turboBlendFuelRecipe,
        
        // Industrial parts
        coolingSystemRecipe,
        coolingDeviceRecipe,
        fusedModularFrameRecipe,
        heatFusedModularFrameRecipe,
        batteryRecipe,
        
        // Nuclear
        nonFissileUraniumRecipe,
        fertileUraniumRecipe,
        encasedUraniumCellRecipe,
    ]
}
