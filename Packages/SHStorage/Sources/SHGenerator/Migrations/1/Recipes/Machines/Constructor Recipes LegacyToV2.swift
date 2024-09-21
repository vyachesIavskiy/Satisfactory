
extension LegacyToV2.Recipes {
    // MARK: - Standard Parts
    static let ironPlateRecipe = Migration.IDs(old: Legacy.Recipes.ironPlateRecipe, new: V2.Recipes.ironPlateRecipe)
    static let ironRodRecipe = Migration.IDs(old: Legacy.Recipes.ironRodRecipe, new: V2.Recipes.ironRodRecipe)
    static let steelRodRecipe = Migration.IDs(old: Legacy.Recipes.ironRodRecipe1, new: V2.Recipes.steelRodRecipe)
    static let screwRecipe = Migration.IDs(old: Legacy.Recipes.screwRecipe, new: V2.Recipes.screwRecipe)
    static let castScrewRecipe = Migration.IDs(old: Legacy.Recipes.screwRecipe1, new: V2.Recipes.castScrewRecipe)
    static let steelScrewRecipe = Migration.IDs(old: Legacy.Recipes.screwRecipe2, new: V2.Recipes.steelScrewRecipe)
    static let copperSheetRecipe = Migration.IDs(old: Legacy.Recipes.copperSheetRecipe, new: V2.Recipes.copperSheetRecipe)
    static let steelBeamRecipe = Migration.IDs(old: Legacy.Recipes.steelBeamRecipe, new: V2.Recipes.steelBeamRecipe)
    static let steelPipeRecipe = Migration.IDs(old: Legacy.Recipes.steelPipeRecipe, new: V2.Recipes.steelPipeRecipe)
    static let aluminumCasingRecipe = Migration.IDs(old: Legacy.Recipes.aluminumCasingRecipe, new: V2.Recipes.aluminumCasingRecipe)
    
    // MARK: - Electronics
    static let wireRecipe = Migration.IDs(old: Legacy.Recipes.wireRecipe, new: V2.Recipes.wireRecipe)
    static let ironWireRecipe = Migration.IDs(old: Legacy.Recipes.wireRecipe1, new: V2.Recipes.ironWireRecipe)
    static let cateriumWireRecipe = Migration.IDs(old: Legacy.Recipes.wireRecipe2, new: V2.Recipes.cateriumWireRecipe)
    static let cableRecipe = Migration.IDs(old: Legacy.Recipes.cableRecipe, new: V2.Recipes.cableRecipe)
    static let quickwireRecipe = Migration.IDs(old: Legacy.Recipes.quickwireRecipe, new: V2.Recipes.quickwireRecipe)
    
    // MARK: - Compounds
    static let concreteRecipe = Migration.IDs(old: Legacy.Recipes.concreteRecipe, new: V2.Recipes.concreteRecipe)
    static let quartzCrystalRecipe = Migration.IDs(old: Legacy.Recipes.quartzCrystalRecipe, new: V2.Recipes.quartzCrystalRecipe)
    static let silicaRecipe = Migration.IDs(old: Legacy.Recipes.silicaRecipe, new: V2.Recipes.silicaRecipe)
    static let copperPowderRecipe = Migration.IDs(old: Legacy.Recipes.copperPowderRecipe, new: V2.Recipes.copperPowderRecipe)
    
    // MARK: - Biomass
    static let biomassLeavesRecipe = Migration.IDs(old: Legacy.Recipes.biomassLeavesRecipe, new: V2.Recipes.biomassLeavesRecipe)
    static let biomassWoodRecipe = Migration.IDs(old: Legacy.Recipes.biomassWoodRecipe, new: V2.Recipes.biomassWoodRecipe)
    static let biomassMyceliaRecipe = Migration.IDs(old: Legacy.Recipes.biomassMyceliaRecipe, new: V2.Recipes.biomassMyceliaRecipe)
    static let biomassAlienProteinRecipe = Migration.IDs(old: Legacy.Recipes.biomassAlienProteinRecipe, new: V2.Recipes.biomassAlienProteinRecipe)
    static let solidBiofuelRecipe = Migration.IDs(old: Legacy.Recipes.solidBiofuelRecipe, new: V2.Recipes.solidBiofuelRecipe)
    static let alienDNACapsuleRecipe = Migration.IDs(old: Legacy.Recipes.alienDNACapsuleRecipe, new: V2.Recipes.alienDNACapsuleRecipe)
    static let bioCoalRecipe = Migration.IDs(old: Legacy.Recipes.bioCoalRecipe, new: V2.Recipes.bioCoalRecipe)
    static let charcoalRecipe = Migration.IDs(old: Legacy.Recipes.charcoalRecipe, new: V2.Recipes.charcoalRecipe)
    
    // MARK: - Containers
    static let emptyCanisterRecipe = Migration.IDs(old: Legacy.Recipes.emptyCanisterRecipe, new: V2.Recipes.emptyCanisterRecipe)
    static let steelCanisterRecipe = Migration.IDs(old: Legacy.Recipes.emptyCanisterRecipe1, new: V2.Recipes.steelCanisterRecipe)
    static let emptyFluidTankRecipe = Migration.IDs(old: Legacy.Recipes.emptyFluidTankRecipe, new: V2.Recipes.emptyFluidTankRecipe)
    
    // MARK: - Alien Remains
    static let hogProteinRecipe = Migration.IDs(old: Legacy.Recipes.hogProteinRecipe, new: V2.Recipes.hogProteinRecipe)
    static let hatcherProteinRecipe = Migration.IDs(old: Legacy.Recipes.hatcherProteinRecipe, new: V2.Recipes.hatcherProteinRecipe)
    static let stingerProteinRecipe = Migration.IDs(old: Legacy.Recipes.stingerProteinRecipe, new: V2.Recipes.stingerProteinRecipe)
    static let spitterProteinRecipe = Migration.IDs(old: Legacy.Recipes.plasmaSpitterProteinRecipe, new: V2.Recipes.spitterProteinRecipe)
    
    // MARK: - Ammunition
    static let ironRebarRecipe = Migration.IDs(old: Legacy.Recipes.ironRebarRecipe, new: V2.Recipes.ironRebarRecipe)
    
    // MARK: - Power Shards
    static let powerShard1Recipe = Migration.IDs(old: Legacy.Recipes.powerShard1Recipe, new: V2.Recipes.powerShard1Recipe)
    static let powerShard2Recipe = Migration.IDs(old: Legacy.Recipes.powerShard2Recipe, new: V2.Recipes.powerShard2Recipe)
    static let powerShard5Recipe = Migration.IDs(old: Legacy.Recipes.powerShard5Recipe, new: V2.Recipes.powerShard5Recipe)
    
    static let constructorRecipes = [
        // Standard Parts
        ironPlateRecipe,
        ironRodRecipe,
        steelRodRecipe,
        screwRecipe,
        castScrewRecipe,
        steelScrewRecipe,
        copperSheetRecipe,
        steelBeamRecipe,
        steelPipeRecipe,
        aluminumCasingRecipe,
        
        // Electronics
        wireRecipe,
        ironWireRecipe,
        cateriumWireRecipe,
        cableRecipe,
        quickwireRecipe,
        
        // Compounds
        concreteRecipe,
        quartzCrystalRecipe,
        silicaRecipe,
        copperPowderRecipe,
        
        // Biomass
        biomassLeavesRecipe,
        biomassWoodRecipe,
        biomassMyceliaRecipe,
        biomassAlienProteinRecipe,
        solidBiofuelRecipe,
        alienDNACapsuleRecipe,
        bioCoalRecipe,
        charcoalRecipe,
        
        // Containers
        emptyCanisterRecipe,
        steelCanisterRecipe,
        emptyFluidTankRecipe,
        
        // Alien Remains
        hogProteinRecipe,
        hatcherProteinRecipe,
        stingerProteinRecipe,
        spitterProteinRecipe,
        
        // Ammunition
        ironRebarRecipe,
        
        // Power Shards
        powerShard1Recipe,
        powerShard2Recipe,
        powerShard5Recipe,
    ]
}
