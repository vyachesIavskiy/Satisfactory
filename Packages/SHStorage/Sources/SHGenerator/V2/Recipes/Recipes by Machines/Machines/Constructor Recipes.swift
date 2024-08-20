import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        input: Ingredient,
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true,
        manuallyCraftable: Bool = true,
        additionalManualCrafting: Building.Static? = nil
    ) {
        self.init(
            id: id,
            inputs: [input],
            output: output,
            machine: V2.Buildings.constructor,
            manualCrafting: (isDefault && manuallyCraftable) ? [V2.Buildings.craftBench] + (additionalManualCrafting.map { [$0] } ?? []) : [],
            duration: duration,
            electricityConsumption: ElectricityConsumption(min: 4, max: 4),
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Standard Parts
    static let ironPlateRecipe = Recipe.Static(
        id: "recipe-iron-plate",
        input: Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 3),
        output: Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 2),
        duration: 6
    )
    
    static let ironRodRecipe = Recipe.Static(
        id: "recipe-iron-rod",
        input: Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.ironRod, amount: 1),
        duration: 4
    )
    
    static let ironRodRecipe1 = Recipe.Static(
        id: "recipe-alternate-steel-rod",
        input: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.ironRod, amount: 4),
        duration: 5,
        isDefault: false
    )
    
    static let screwRecipe = Recipe.Static(
        id: "recipe-screw",
        input: Recipe.Static.Ingredient(V2.Parts.ironRod, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.screw, amount: 4),
        duration: 6
    )
    
    static let screwRecipe1 = Recipe.Static(
        id: "recipe-alternate-cast-screw",
        input: Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 5),
        output: Recipe.Static.Ingredient(V2.Parts.screw, amount: 20),
        duration: 24,
        isDefault: false
    )
    
    static let screwRecipe2 = Recipe.Static(
        id: "recipe-alternate-steel-screw",
        input: Recipe.Static.Ingredient(V2.Parts.steelBeam, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.screw, amount: 52),
        duration: 12,
        isDefault: false
    )
    
    static let copperSheetRecipe = Recipe.Static(
        id: "recipe-copper-sheet",
        input: Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 2),
        output: Recipe.Static.Ingredient(V2.Parts.copperSheet, amount: 1),
        duration: 6
    )
    
    static let steelBeamRecipe = Recipe.Static(
        id: "recipe-steel-beam",
        input: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 4),
        output: Recipe.Static.Ingredient(V2.Parts.steelBeam, amount: 1),
        duration: 4
    )
    
    static let steelPipeRecipe = Recipe.Static(
        id: "recipe-steel-pipe",
        input: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 3),
        output: Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 2),
        duration: 6
    )
    
    static let aluminumCasingRecipe = Recipe.Static(
        id: "recipe-aluminum-casing",
        input: Recipe.Static.Ingredient(V2.Parts.aluminumIngot, amount: 3),
        output: Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 2),
        duration: 2
    )
    
    // MARK: - Electronics
    static let wireRecipe = Recipe.Static(
        id: "recipe-wire",
        input: Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.wire, amount: 2),
        duration: 4
    )
    
    static let wireRecipe1 = Recipe.Static(
        id: "recipe-alternate-iron-wire",
        input: Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 5),
        output: Recipe.Static.Ingredient(V2.Parts.wire, amount: 9),
        duration: 24,
        isDefault: false
    )
    
    static let wireRecipe2 = Recipe.Static(
        id: "recipe-alternate-caterium-wire",
        input: Recipe.Static.Ingredient(V2.Parts.cateriumIngot, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.wire, amount: 8),
        duration: 4,
        isDefault: false
    )
    
    static let cableRecipe = Recipe.Static(
        id: "recipe-cable",
        input: Recipe.Static.Ingredient(V2.Parts.wire, amount: 2),
        output: Recipe.Static.Ingredient(V2.Parts.cable, amount: 1),
        duration: 2
    )
    
    static let quickwireRecipe = Recipe.Static(
        id: "recipe-quickwire",
        input: Recipe.Static.Ingredient(V2.Parts.cateriumIngot, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 5),
        duration: 5
    )
    
    // MARK: - Minerals
    static let concreteRecipe = Recipe.Static(
        id: "recipe-concrete",
        input: Recipe.Static.Ingredient(V2.Parts.limestone, amount: 3),
        output: Recipe.Static.Ingredient(V2.Parts.concrete, amount: 1),
        duration: 4
    )
    
    static let quartzCrystalRecipe = Recipe.Static(
        id: "recipe-quartz-crystal",
        input: Recipe.Static.Ingredient(V2.Parts.rawQuartz, amount: 5),
        output: Recipe.Static.Ingredient(V2.Parts.quartzCrystal, amount: 3),
        duration: 8
    )
    
    static let silicaRecipe = Recipe.Static(
        id: "recipe-silica",
        input: Recipe.Static.Ingredient(V2.Parts.rawQuartz, amount: 3),
        output: Recipe.Static.Ingredient(V2.Parts.silica, amount: 5),
        duration: 8
    )
    
    static let copperPowderRecipe = Recipe.Static(
        id: "recipe-copper-powder",
        input: Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 30),
        output: Recipe.Static.Ingredient(V2.Parts.copperPowder, amount: 5),
        duration: 6
    )
    
    // MARK: - Biomass
    static let colorCartridgeRecipe = Recipe.Static(
        id: "recipe-color-cartridge",
        input: Recipe.Static.Ingredient(V2.Parts.flowerPetals, amount: 5),
        output: Recipe.Static.Ingredient(V2.Parts.colorCartridge, amount: 10),
        duration: 8
    )
    
    static let biomassLeavesRecipe = Recipe.Static(
        id: "recipe-biomass-leaves",
        input: Recipe.Static.Ingredient(V2.Parts.leaves, amount: 10),
        output: Recipe.Static.Ingredient(V2.Parts.biomass, amount: 5),
        duration: 5
    )
    
    static let biomassWoodRecipe = Recipe.Static(
        id: "recipe-biomass-wood",
        input: Recipe.Static.Ingredient(V2.Parts.wood, amount: 4),
        output: Recipe.Static.Ingredient(V2.Parts.biomass, amount: 20),
        duration: 4
    )
    
    static let biomassMyceliaRecipe = Recipe.Static(
        id: "recipe-biomass-mycelia",
        input: Recipe.Static.Ingredient(V2.Parts.mycelia, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.biomass, amount: 10),
        duration: 4
    )
    
    static let biomassAlienProteinRecipe = Recipe.Static(
        id: "recipe-biomass-alien-protein",
        input: Recipe.Static.Ingredient(V2.Parts.alienProtein, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.biomass, amount: 100),
        duration: 4
    )
    
    static let solidBiofuelRecipe = Recipe.Static(
        id: "recipe-solid-biofuel",
        input: Recipe.Static.Ingredient(V2.Parts.biomass, amount: 8),
        output: Recipe.Static.Ingredient(V2.Parts.solidBiofuel, amount: 4),
        duration: 4
    )
    
    static let bioCoalRecipe = Recipe.Static(
        id: "recipe-alternate-biocoal",
        input: Recipe.Static.Ingredient(V2.Parts.biomass, amount: 5),
        output: Recipe.Static.Ingredient(V2.Parts.coal, amount: 6),
        duration: 8,
        isDefault: false
    )
    
    static let charcoalRecipe = Recipe.Static(
        id: "recipe-alternate-charcoal",
        input: Recipe.Static.Ingredient(V2.Parts.wood, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.coal, amount: 10),
        duration: 4,
        isDefault: false
    )
    
    // MARK: - Containers
    static let emptyCanisterRecipe = Recipe.Static(
        id: "recipe-empty-canister",
        input: Recipe.Static.Ingredient(V2.Parts.plastic, amount: 2),
        output: Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 4),
        duration: 4
    )
    
    static let emptyCanisterRecipe1 = Recipe.Static(
        id: "recipe-alternate-steel-canister",
        input: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 3),
        output: Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2),
        duration: 3,
        isDefault: false
    )
    
    static let emptyFluidTankRecipe = Recipe.Static(
        id: "recipe-empty-fluid-tank",
        input: Recipe.Static.Ingredient(V2.Parts.aluminumIngot, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.emptyFluidTank, amount: 1),
        duration: 1
    )
    
    // MARK: - Alien Remains
    static let hogProteinRecipe = Recipe.Static(
        id: "recipe-hog-protein",
        input: Recipe.Static.Ingredient(V2.Parts.hogRemains, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.alienProtein, amount: 1),
        duration: 3
    )
    
    static let hatcherProteinRecipe = Recipe.Static(
        id: "recipe-hatcher-protein",
        input: Recipe.Static.Ingredient(V2.Parts.hatcherRemains, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.alienProtein, amount: 1),
        duration: 3
    )
    
    static let stingerProteinRecipe = Recipe.Static(
        id: "recipe-stinger-protein",
        input: Recipe.Static.Ingredient(V2.Parts.stingerRemains, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.alienProtein, amount: 1),
        duration: 3
    )
    
    static let plasmaSpitterProteinRecipe = Recipe.Static(
        id: "recipe-plasma-spitter-protein",
        input: Recipe.Static.Ingredient(V2.Parts.plasmaSpitterRemains, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.alienProtein, amount: 1),
        duration: 3
    )
    
    static let alienDNACapsuleRecipe = Recipe.Static(
        id: "recipe-alien-dna-capsule",
        input: Recipe.Static.Ingredient(V2.Parts.alienProtein, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.alienDNACapsule, amount: 1),
        duration: 6
    )
    
    // MARK: - Power Shards
    static let powerShard1Recipe = Recipe.Static(
        id: "recipe-power-shard-1",
        input: Recipe.Static.Ingredient(V2.Parts.bluePowerSlug, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.powerShard, amount: 1),
        duration: 8
    )
    
    static let powerShard2Recipe = Recipe.Static(
        id: "recipe-power-shard-2",
        input: Recipe.Static.Ingredient(V2.Parts.yellowPowerSlug, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.powerShard, amount: 2),
        duration: 12
    )
    
    static let powerShard5Recipe = Recipe.Static(
        id: "recipe-power-shard-5",
        input: Recipe.Static.Ingredient(V2.Parts.purplePowerSlug, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.powerShard, amount: 5),
        duration: 24
    )
    
    // MARK: - Ammunition
    static let ironRebarRecipe = Recipe.Static(
        id: "recipe-iron-rebar",
        input: Recipe.Static.Ingredient(V2.Parts.ironRod, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.ironRebar, amount: 1),
        duration: 4,
        additionalManualCrafting: V2.Buildings.equipmentWorkshop
    )
    
    // MARK: - FICSMAS
    static let ficsmasTreeBranchRecipe = Recipe.Static(
        id: "recipe-ficsmas-tree-branch",
        input: Recipe.Static.Ingredient(V2.Parts.ficsmasGift, amount: 1),
        output: Recipe.Static.Ingredient(V2.Parts.ficsmasTreeBranch, amount: 1),
        duration: 6,
        manuallyCraftable: false
    )
    
    static let candyCanePartRecipe = Recipe.Static(
        id: "recipe-candy-cane",
        input: Recipe.Static.Ingredient(V2.Parts.ficsmasGift, amount: 3),
        output: Recipe.Static.Ingredient(V2.Parts.candyCanePart, amount: 1),
        duration: 12,
        manuallyCraftable: false
    )
    
    static let ficsmasBowRecipe = Recipe.Static(
        id: "recipe-ficsmas-bow",
        input: Recipe.Static.Ingredient(V2.Parts.ficsmasGift, amount: 2),
        output: Recipe.Static.Ingredient(V2.Parts.ficsmasBow, amount: 1),
        duration: 12,
        manuallyCraftable: false
    )
    
    static let actualSnowRecipe = Recipe.Static(
        id: "recipe-actual-snow",
        input: Recipe.Static.Ingredient(V2.Parts.ficsmasGift, amount: 5),
        output: Recipe.Static.Ingredient(V2.Parts.actualSnow, amount: 2),
        duration: 12,
        manuallyCraftable: false
    )
    
    static let snowballRecipe = Recipe.Static(
        id: "recipe-snowball",
        input: Recipe.Static.Ingredient(V2.Parts.actualSnow, amount: 3),
        output: Recipe.Static.Ingredient(V2.Parts.snowball, amount: 1),
        duration: 12,
        manuallyCraftable: false
    )
    
    static let constructorRecipes = [
        ironPlateRecipe,
        ironRodRecipe,
        ironRodRecipe1,
        screwRecipe,
        screwRecipe1,
        screwRecipe2,
        copperSheetRecipe,
        steelBeamRecipe,
        steelPipeRecipe,
        aluminumCasingRecipe,
        wireRecipe,
        wireRecipe1,
        wireRecipe2,
        cableRecipe,
        quickwireRecipe,
        concreteRecipe,
        quartzCrystalRecipe,
        silicaRecipe,
        copperPowderRecipe,
        colorCartridgeRecipe,
        biomassLeavesRecipe,
        biomassWoodRecipe,
        biomassMyceliaRecipe,
        biomassAlienProteinRecipe,
        solidBiofuelRecipe,
        bioCoalRecipe,
        charcoalRecipe,
        emptyCanisterRecipe,
        emptyCanisterRecipe1,
        emptyFluidTankRecipe,
        hogProteinRecipe,
        hatcherProteinRecipe,
        stingerProteinRecipe,
        plasmaSpitterProteinRecipe,
        alienDNACapsuleRecipe,
        powerShard1Recipe,
        powerShard2Recipe,
        powerShard5Recipe,
        ironRebarRecipe,
        ficsmasTreeBranchRecipe,
        candyCanePartRecipe,
        ficsmasBowRecipe,
        actualSnowRecipe,
        snowballRecipe
    ]
}
