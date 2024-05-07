
extension LegacyToV2.Recipes {
    // Ingots
    static let ironIngotRecipe2 = Migration.IDs(old: Legacy.Recipes.ironIngotRecipe2, new: V2.Recipes.ironIngotRecipe2)
    static let copperIngotRecipe2 = Migration.IDs(old: Legacy.Recipes.copperIngotRecipe2, new: V2.Recipes.copperIngotRecipe2)
    static let cateriumIngotRecipe1 = Migration.IDs(old: Legacy.Recipes.cateriumIngotRecipe1, new: V2.Recipes.cateriumIngotRecipe1)

    // Minerals
    static let concreteRecipe3 = Migration.IDs(old: Legacy.Recipes.concreteRecipe3, new: V2.Recipes.concreteRecipe3)
    static let quartzCrystalRecipe1 = Migration.IDs(old: Legacy.Recipes.quartzCrystalRecipe1, new: V2.Recipes.quartzCrystalRecipe1)

    // Biomass
    static let fabricRecipe1 = Migration.IDs(old: Legacy.Recipes.fabricRecipe1, new: V2.Recipes.fabricRecipe1)

    // Standard Parts
    static let copperSheetRecipe1 = Migration.IDs(old: Legacy.Recipes.copperSheetRecipe1, new: V2.Recipes.copperSheetRecipe1)

    // Electronics
    static let cableRecipe3 = Migration.IDs(old: Legacy.Recipes.cableRecipe3, new: V2.Recipes.cableRecipe3)

    // Advanced Refinement
    static let aluminumScrapRecipe = Migration.IDs(old: Legacy.Recipes.aluminumScrapRecipe, new: V2.Recipes.aluminumScrapRecipe)
    static let aluminumScrapRecipe1 = Migration.IDs(old: Legacy.Recipes.aluminumScrapRecipe1, new: V2.Recipes.aluminumScrapRecipe1)
    static let aluminaSolutionRecipe = Migration.IDs(old: Legacy.Recipes.aluminaSolutionRecipe, new: V2.Recipes.aluminaSolutionRecipe)
    static let aluminaSolutionRecipe1 = Migration.IDs(old: Legacy.Recipes.aluminaSolutionRecipe1, new: V2.Recipes.aluminaSolutionRecipe1)
    static let sulfuricAcidRecipe = Migration.IDs(old: Legacy.Recipes.sulfuricAcidRecipe, new: V2.Recipes.sulfuricAcidRecipe)


    // Oil Products
    static let plasticRecipe = Migration.IDs(old: Legacy.Recipes.plasticRecipe, new: V2.Recipes.plasticRecipe)
    static let residualPlasticRecipe = Migration.IDs(old: Legacy.Recipes.residualPlasticRecipe, new: V2.Recipes.residualPlasticRecipe)
    static let plasticRecipe1 = Migration.IDs(old: Legacy.Recipes.plasticRecipe1, new: V2.Recipes.plasticRecipe1)
    static let rubberRecipe = Migration.IDs(old: Legacy.Recipes.rubberRecipe, new: V2.Recipes.rubberRecipe)
    static let residualRubberRecipe = Migration.IDs(old: Legacy.Recipes.residualRubberRecipe, new: V2.Recipes.residualRubberRecipe)
    static let rubberRecipe1 = Migration.IDs(old: Legacy.Recipes.rubberRecipe1, new: V2.Recipes.rubberRecipe1)
    static let petroleumCokeRecipe = Migration.IDs(old: Legacy.Recipes.petroleumCokeRecipe, new: V2.Recipes.petroleumCokeRecipe)
    static let polymerResinRecipe1 = Migration.IDs(old: Legacy.Recipes.polymerResinRecipe1, new: V2.Recipes.polymerResinRecipe1)
    static let heavyOilResidueRecipe1 = Migration.IDs(old: Legacy.Recipes.heavyOilResidueRecipe1, new: V2.Recipes.heavyOilResidueRecipe1)

    // Fuel
    static let fuelRecipe = Migration.IDs(old: Legacy.Recipes.fuelRecipe, new: V2.Recipes.fuelRecipe)
    static let residualFuelRecipe = Migration.IDs(old: Legacy.Recipes.residualFuelRecipe, new: V2.Recipes.residualFuelRecipe)
    static let fuelRecipe1 = Migration.IDs(old: Legacy.Recipes.fuelRecipe1, new: V2.Recipes.packagedFuelRecipe1)
    static let liquidBiofuelRecipe = Migration.IDs(old: Legacy.Recipes.liquidBiofuelRecipe, new: V2.Recipes.liquidBiofuelRecipe)
    static let turbofuelRecipe = Migration.IDs(old: Legacy.Recipes.turbofuelRecipe, new: V2.Recipes.turbofuelRecipe)
    static let turbofuelRecipe1 = Migration.IDs(old: Legacy.Recipes.turbofuelRecipe1, new: V2.Recipes.turbofuelRecipe1)
    
    // Cosumed
    static let smokelessPowderRecipe = Migration.IDs(old: Legacy.Recipes.smokelessPowderRecipe, new: V2.Recipes.smokelessPowderRecipe)

    static let refineryRecipes = [
        // ingots
        ironIngotRecipe2,
        copperIngotRecipe2,
        cateriumIngotRecipe1,
        
        // minerals
        concreteRecipe3,
        quartzCrystalRecipe1,
        
        // biomass
        fabricRecipe1,
        
        // standart parts
        copperSheetRecipe1,
        
        // electronics
        cableRecipe3,
        
        // advanced refinement
        aluminumScrapRecipe,
        aluminumScrapRecipe1,
        aluminaSolutionRecipe,
        aluminaSolutionRecipe1,
        sulfuricAcidRecipe,
        
        // oil products
        plasticRecipe,
        residualPlasticRecipe,
        plasticRecipe1,
        rubberRecipe,
        residualRubberRecipe,
        rubberRecipe1,
        petroleumCokeRecipe,
        polymerResinRecipe1,
        heavyOilResidueRecipe1,
        
        // fuel
        fuelRecipe,
        residualFuelRecipe,
        fuelRecipe1,
        liquidBiofuelRecipe,
        turbofuelRecipe,
        turbofuelRecipe1,
        
        // Consumed
        smokelessPowderRecipe,
    ]
}
