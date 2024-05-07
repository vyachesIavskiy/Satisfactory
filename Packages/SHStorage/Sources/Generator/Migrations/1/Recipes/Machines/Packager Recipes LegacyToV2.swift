
extension LegacyToV2.Recipes {
    // MARK: - Packaging
    static let packagedWaterRecipe = Migration.IDs(old: Legacy.Recipes.packagedWaterRecipe, new: V2.Recipes.packagedWaterRecipe)
    static let packagedOilRecipe = Migration.IDs(old: Legacy.Recipes.packagedOilRecipe, new: V2.Recipes.packagedOilRecipe)
    static let packagedHeavyOilResidueRecipe = Migration.IDs(old: Legacy.Recipes.packagedHeavyOilResidueRecipe, new: V2.Recipes.packagedHeavyOilResidueRecipe)
    static let packagedLiquidBiofuelRecipe = Migration.IDs(old: Legacy.Recipes.packagedLiquidBiofuelRecipe, new: V2.Recipes.packagedLiquidBiofuelRecipe)
    static let packagedFuelRecipe = Migration.IDs(old: Legacy.Recipes.packagedFuelRecipe, new: V2.Recipes.packagedFuelRecipe)
    static let packagedTurbofuelRecipe = Migration.IDs(old: Legacy.Recipes.packagedTurbofuelRecipe, new: V2.Recipes.packagedTurbofuelRecipe)
    static let packagedAluminaSolutionRecipe = Migration.IDs(old: Legacy.Recipes.packagedAluminaSolutionRecipe, new: V2.Recipes.packagedAluminaSolutionRecipe)
    static let packagedSulfuricAcidRecipe = Migration.IDs(old: Legacy.Recipes.packagedSulfuricAcidRecipe, new: V2.Recipes.packagedSulfuricAcidRecipe)
    static let packagedNitrogenGasRecipe = Migration.IDs(old: Legacy.Recipes.packagedNitrogenGasRecipe, new: V2.Recipes.packagedNitrogenGasRecipe)
    static let packagedNitricAcidRecipe = Migration.IDs(old: Legacy.Recipes.packagedNitricAcidRecipe, new: V2.Recipes.packagedNitricAcidRecipe)

    // MARK: - Unpackaging
    static let unpackagedWaterRecipe = Migration.IDs(old: Legacy.Recipes.unpackagedWaterRecipe, new: V2.Recipes.unpackagedWaterRecipe)
    static let unpackagedOilRecipe = Migration.IDs(old: Legacy.Recipes.unpackagedOilRecipe, new: V2.Recipes.unpackagedOilRecipe)
    static let unpackagedHeavyOilResidueRecipe = Migration.IDs(old: Legacy.Recipes.unpackagedHeavyOilResidueRecipe, new: V2.Recipes.unpackagedHeavyOilResidueRecipe)
    static let unpackagedLiquidBiofuelRecipe = Migration.IDs(old: Legacy.Recipes.unpackagedLiquidBiofuelRecipe, new: V2.Recipes.unpackagedLiquidBiofuelRecipe)
    static let unpackagedFuelRecipe = Migration.IDs(old: Legacy.Recipes.unpackagedFuelRecipe, new: V2.Recipes.unpackagedFuelRecipe)
    static let unpackagedTurbofuelRecipe = Migration.IDs(old: Legacy.Recipes.unpackagedTurbofuelRecipe, new: V2.Recipes.unpackagedTurbofuelRecipe)
    static let unpackagedAluminaSolutionRecipe = Migration.IDs(old: Legacy.Recipes.unpackagedAluminaSolutionRecipe, new: V2.Recipes.unpackagedAluminaSolutionRecipe)
    static let unpackagedSulfuricAcidRecipe = Migration.IDs(old: Legacy.Recipes.unpackagedSulfuricAcidRecipe, new: V2.Recipes.unpackagedSulfuricAcidRecipe)
    static let unpackagedNitrogenGasRecipe = Migration.IDs(old: Legacy.Recipes.unpackagedNitrogenGasRecipe, new: V2.Recipes.unpackagedNitrogenGasRecipe)
    static let unpackagedNitricAcidRecipe = Migration.IDs(old: Legacy.Recipes.unpackagedNitricAcidRecipe, new: V2.Recipes.unpackagedNitricAcidRecipe)

    static let packagerRecipes = [
        // Packaging
        packagedWaterRecipe,
        packagedOilRecipe,
        packagedHeavyOilResidueRecipe,
        packagedLiquidBiofuelRecipe,
        packagedFuelRecipe,
        packagedTurbofuelRecipe,
        packagedAluminaSolutionRecipe,
        packagedSulfuricAcidRecipe,
        packagedNitrogenGasRecipe,
        packagedNitricAcidRecipe,
        
        // Unpackaging
        unpackagedWaterRecipe,
        unpackagedOilRecipe,
        unpackagedHeavyOilResidueRecipe,
        unpackagedLiquidBiofuelRecipe,
        unpackagedFuelRecipe,
        unpackagedTurbofuelRecipe,
        unpackagedAluminaSolutionRecipe,
        unpackagedSulfuricAcidRecipe,
        unpackagedNitrogenGasRecipe,
        unpackagedNitricAcidRecipe
    ]
}
