
extension LegacyToV2.Recipes {
    // MARK: - Oil Products
    static let plasticRecipe = Migration.IDs(old: Legacy.Recipes.plasticRecipe, new: V2.Recipes.plasticRecipe)
    static let residualPlasticRecipe = Migration.IDs(old: Legacy.Recipes.residualPlasticRecipe, new: V2.Recipes.residualPlasticRecipe)
    static let recycledPlasticRecipe = Migration.IDs(old: Legacy.Recipes.plasticRecipe1, new: V2.Recipes.recycledPlasticRecipe)
    static let rubberRecipe = Migration.IDs(old: Legacy.Recipes.rubberRecipe, new: V2.Recipes.rubberRecipe)
    static let residualRubberRecipe = Migration.IDs(old: Legacy.Recipes.residualRubberRecipe, new: V2.Recipes.residualRubberRecipe)
    static let recycledRubberRecipe = Migration.IDs(old: Legacy.Recipes.rubberRecipe1, new: V2.Recipes.recycledRubberRecipe)
    static let petroleumCokeRecipe = Migration.IDs(old: Legacy.Recipes.petroleumCokeRecipe, new: V2.Recipes.petroleumCokeRecipe)
    static let polymerResinRecipe = Migration.IDs(old: Legacy.Recipes.polymerResinRecipe1, new: V2.Recipes.polymerResinRecipe)
    static let heavyOilResidueRecipe = Migration.IDs(old: Legacy.Recipes.heavyOilResidueRecipe1, new: V2.Recipes.heavyOilResidueRecipe)
    
    // MARK: - Advanced Refinement
    static let aluminumScrapRecipe = Migration.IDs(old: Legacy.Recipes.aluminumScrapRecipe, new: V2.Recipes.aluminumScrapRecipe)
    static let electrodeAluminumScrapRecipe = Migration.IDs(old: Legacy.Recipes.aluminumScrapRecipe1, new: V2.Recipes.electrodeAluminumScrapRecipe)
    static let aluminaSolutionRecipe = Migration.IDs(old: Legacy.Recipes.aluminaSolutionRecipe, new: V2.Recipes.aluminaSolutionRecipe)
    static let sloppyAluminaRecipe = Migration.IDs(old: Legacy.Recipes.aluminaSolutionRecipe1, new: V2.Recipes.sloppyAluminaRecipe)
    static let sulfuricAcidRecipe = Migration.IDs(old: Legacy.Recipes.sulfuricAcidRecipe, new: V2.Recipes.sulfuricAcidRecipe)
    
    // MARK: - Fuel
    static let fuelRecipe = Migration.IDs(old: Legacy.Recipes.fuelRecipe, new: V2.Recipes.fuelRecipe)
    static let residualFuelRecipe = Migration.IDs(old: Legacy.Recipes.residualFuelRecipe, new: V2.Recipes.residualFuelRecipe)
    static let dilutedPackagedFuelRecipe = Migration.IDs(old: Legacy.Recipes.fuelRecipe1, new: V2.Recipes.dilutedPackagedFuelRecipe)
    static let liquidBiofuelRecipe = Migration.IDs(old: Legacy.Recipes.liquidBiofuelRecipe, new: V2.Recipes.liquidBiofuelRecipe)
    static let turbofuelRecipe = Migration.IDs(old: Legacy.Recipes.turbofuelRecipe, new: V2.Recipes.turbofuelRecipe)
    static let turboHeavyFuelRecipe = Migration.IDs(old: Legacy.Recipes.turbofuelRecipe1, new: V2.Recipes.turboHeavyFuelRecipe)
    
    // MARK: - Ingots
    static let pureIronIngotRecipe = Migration.IDs(old: Legacy.Recipes.ironIngotRecipe2, new: V2.Recipes.pureIronIngotRecipe)
    static let pureCopperIngotRecipe = Migration.IDs(old: Legacy.Recipes.copperIngotRecipe2, new: V2.Recipes.pureCopperIngotRecipe)
    static let pureCateriumIngotRecipe = Migration.IDs(old: Legacy.Recipes.cateriumIngotRecipe1, new: V2.Recipes.pureCateriumIngotRecipe)

    // MARK: - Compounds
    static let wetConcreteRecipe = Migration.IDs(old: Legacy.Recipes.concreteRecipe3, new: V2.Recipes.wetConcreteRecipe)
    static let pureQuartzCrystalRecipe = Migration.IDs(old: Legacy.Recipes.quartzCrystalRecipe1, new: V2.Recipes.pureQuartzCrystalRecipe)

    // MARK: - Other
    static let coatedCableRecipe = Migration.IDs(old: Legacy.Recipes.cableRecipe3, new: V2.Recipes.coatedCableRecipe)
    static let steamedCopperSheetRecipe = Migration.IDs(old: Legacy.Recipes.copperSheetRecipe1, new: V2.Recipes.steamedCopperSheetRecipe)
    static let polyesterFabricRecipe = Migration.IDs(old: Legacy.Recipes.fabricRecipe1, new: V2.Recipes.polyesterFabricRecipe)
    
    // MARK: - Ammunition
    static let smokelessPowderRecipe = Migration.IDs(old: Legacy.Recipes.smokelessPowderRecipe, new: V2.Recipes.smokelessPowderRecipe)

    static let refineryRecipes = [
        // Oil Products
        plasticRecipe,
        residualPlasticRecipe,
        recycledPlasticRecipe,
        rubberRecipe,
        residualRubberRecipe,
        recycledRubberRecipe,
        petroleumCokeRecipe,
        polymerResinRecipe,
        heavyOilResidueRecipe,
        
        // Advanced Refinement
        aluminumScrapRecipe,
        electrodeAluminumScrapRecipe,
        aluminaSolutionRecipe,
        sloppyAluminaRecipe,
        sulfuricAcidRecipe,
        
        // Fuel
        fuelRecipe,
        residualFuelRecipe,
        dilutedPackagedFuelRecipe,
        liquidBiofuelRecipe,
        turbofuelRecipe,
        turboHeavyFuelRecipe,
        
        // Ingots
        pureIronIngotRecipe,
        pureCopperIngotRecipe,
        pureCateriumIngotRecipe,

        // Compounds
        wetConcreteRecipe,
        pureQuartzCrystalRecipe,

        // Other
        coatedCableRecipe,
        steamedCopperSheetRecipe,
        polyesterFabricRecipe,
        
        // Ammunition
        smokelessPowderRecipe,
    ]
}
