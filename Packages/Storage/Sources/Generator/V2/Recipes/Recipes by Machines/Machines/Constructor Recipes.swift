import StaticModels

private extension Recipe {
    init(
        id: String,
        input: Ingredient,
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: [input],
            output: output,
            machines: isDefault ? [V2.Buildings.constructor, V2.Buildings.craftBench] : [V2.Buildings.constructor],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Standard Parts
    static let ironPlateRecipe = Recipe(
        id: "recipe-iron-plate",
        input: Recipe.Ingredient(V2.Parts.ironIngot, amount: 3),
        output: Recipe.Ingredient(V2.Parts.ironPlate, amount: 2),
        duration: 6
    )
    
    static let ironRodRecipe = Recipe(
        id: "recipe-iron-rod",
        input: Recipe.Ingredient(V2.Parts.ironIngot, amount: 1),
        output: Recipe.Ingredient(V2.Parts.ironRod, amount: 1),
        duration: 4
    )
    
    static let ironRodRecipe1 = Recipe(
        id: "recipe-alternate-steel-rod",
        input: Recipe.Ingredient(V2.Parts.steelIngot, amount: 1),
        output: Recipe.Ingredient(V2.Parts.ironRod, amount: 4),
        duration: 5,
        isDefault: false
    )
    
    static let screwRecipe = Recipe(
        id: "recipe-screw",
        input: Recipe.Ingredient(V2.Parts.ironRod, amount: 1),
        output: Recipe.Ingredient(V2.Parts.screw, amount: 4),
        duration: 6
    )
    
    static let screwRecipe1 = Recipe(
        id: "recipe-alternate-cast-screw",
        input: Recipe.Ingredient(V2.Parts.ironIngot, amount: 5),
        output: Recipe.Ingredient(V2.Parts.screw, amount: 20),
        duration: 24,
        isDefault: false
    )
    
    static let screwRecipe2 = Recipe(
        id: "recipe-alternate-steel-screw",
        input: Recipe.Ingredient(V2.Parts.steelBeam, amount: 1),
        output: Recipe.Ingredient(V2.Parts.screw, amount: 52),
        duration: 12,
        isDefault: false
    )
    
    static let copperSheetRecipe = Recipe(
        id: "recipe-copper-sheet",
        input: Recipe.Ingredient(V2.Parts.copperIngot, amount: 2),
        output: Recipe.Ingredient(V2.Parts.copperSheet, amount: 1),
        duration: 6
    )
    
    static let steelBeamRecipe = Recipe(
        id: "recipe-steel-beam",
        input: Recipe.Ingredient(V2.Parts.steelIngot, amount: 4),
        output: Recipe.Ingredient(V2.Parts.steelBeam, amount: 1),
        duration: 4
    )
    
    static let steelPipeRecipe = Recipe(
        id: "recipe-steel-pipe",
        input: Recipe.Ingredient(V2.Parts.steelIngot, amount: 3),
        output: Recipe.Ingredient(V2.Parts.steelPipe, amount: 2),
        duration: 6
    )
    
    static let aluminumCasingRecipe = Recipe(
        id: "recipe-aluminum-casing",
        input: Recipe.Ingredient(V2.Parts.aluminumIngot, amount: 3),
        output: Recipe.Ingredient(V2.Parts.aluminumCasing, amount: 2),
        duration: 2
    )
    
    // MARK: - Electronics
    static let wireRecipe = Recipe(
        id: "recipe-wire",
        input: Recipe.Ingredient(V2.Parts.copperIngot, amount: 1),
        output: Recipe.Ingredient(V2.Parts.wire, amount: 2),
        duration: 4
    )
    
    static let wireRecipe1 = Recipe(
        id: "recipe-alternate-iron-wire",
        input: Recipe.Ingredient(V2.Parts.ironIngot, amount: 5),
        output: Recipe.Ingredient(V2.Parts.wire, amount: 9),
        duration: 24,
        isDefault: false
    )
    
    static let wireRecipe2 = Recipe(
        id: "recipe-alternate-caterium-wire",
        input: Recipe.Ingredient(V2.Parts.cateriumIngot, amount: 1),
        output: Recipe.Ingredient(V2.Parts.wire, amount: 8),
        duration: 4,
        isDefault: false
    )
    
    static let cableRecipe = Recipe(
        id: "recipe-cable",
        input: Recipe.Ingredient(V2.Parts.wire, amount: 2),
        output: Recipe.Ingredient(V2.Parts.cable, amount: 1),
        duration: 2
    )
    
    static let quickwireRecipe = Recipe(
        id: "recipe-quickwire",
        input: Recipe.Ingredient(V2.Parts.cateriumIngot, amount: 1),
        output: Recipe.Ingredient(V2.Parts.quickwire, amount: 5),
        duration: 5
    )
    
    // MARK: - Minerals
    static let concreteRecipe = Recipe(
        id: "recipe-concrete",
        input: Recipe.Ingredient(V2.Parts.limestone, amount: 3),
        output: Recipe.Ingredient(V2.Parts.concrete, amount: 1),
        duration: 4
    )
    
    static let quartzCrystalRecipe = Recipe(
        id: "recipe-quartz-crystal",
        input: Recipe.Ingredient(V2.Parts.rawQuartz, amount: 5),
        output: Recipe.Ingredient(V2.Parts.quartzCrystal, amount: 3),
        duration: 8
    )
    
    static let silicaRecipe = Recipe(
        id: "recipe-silica",
        input: Recipe.Ingredient(V2.Parts.rawQuartz, amount: 3),
        output: Recipe.Ingredient(V2.Parts.silica, amount: 5),
        duration: 8
    )
    
    static let copperPowderRecipe = Recipe(
        id: "recipe-copper-powder",
        input: Recipe.Ingredient(V2.Parts.copperIngot, amount: 30),
        output: Recipe.Ingredient(V2.Parts.copperPowder, amount: 5),
        duration: 6
    )
    
    // MARK: - Biomass
    static let colorCartridgeRecipe = Recipe(
        id: "recipe-color-cartridge",
        input: Recipe.Ingredient(V2.Parts.flowerPetals, amount: 5),
        output: Recipe.Ingredient(V2.Parts.colorCartridge, amount: 10),
        duration: 8
    )
    
    static let biomassLeavesRecipe = Recipe(
        id: "recipe-biomass-leaves",
        input: Recipe.Ingredient(V2.Parts.leaves, amount: 10),
        output: Recipe.Ingredient(V2.Parts.biomass, amount: 5),
        duration: 5
    )
    
    static let biomassWoodRecipe = Recipe(
        id: "recipe-biomass-wood",
        input: Recipe.Ingredient(V2.Parts.wood, amount: 4),
        output: Recipe.Ingredient(V2.Parts.biomass, amount: 20),
        duration: 4
    )
    
    static let biomassMyceliaRecipe = Recipe(
        id: "recipe-biomass-mycelia",
        input: Recipe.Ingredient(V2.Parts.mycelia, amount: 1),
        output: Recipe.Ingredient(V2.Parts.biomass, amount: 10),
        duration: 4
    )
    
    static let biomassAlienProteinRecipe = Recipe(
        id: "recipe-biomass-alien-protein",
        input: Recipe.Ingredient(V2.Parts.alienProtein, amount: 1),
        output: Recipe.Ingredient(V2.Parts.biomass, amount: 100),
        duration: 4
    )
    
    static let solidBiofuelRecipe = Recipe(
        id: "recipe-solid-biofuel",
        input: Recipe.Ingredient(V2.Parts.biomass, amount: 8),
        output: Recipe.Ingredient(V2.Parts.solidBiofuel, amount: 4),
        duration: 4
    )
    
    static let bioCoalRecipe = Recipe(
        id: "recipe-alternate-biocoal",
        input: Recipe.Ingredient(V2.Parts.biomass, amount: 5),
        output: Recipe.Ingredient(V2.Parts.coal, amount: 6),
        duration: 8,
        isDefault: false
    )
    
    static let charcoalRecipe = Recipe(
        id: "recipe-alternate-charcoal",
        input: Recipe.Ingredient(V2.Parts.wood, amount: 1),
        output: Recipe.Ingredient(V2.Parts.coal, amount: 10),
        duration: 4,
        isDefault: false
    )
    
    // MARK: - Containers
    static let emptyCanisterRecipe = Recipe(
        id: "recipe-empty-canister",
        input: Recipe.Ingredient(V2.Parts.plastic, amount: 2),
        output: Recipe.Ingredient(V2.Parts.emptyCanister, amount: 4),
        duration: 4
    )
    
    static let emptyCanisterRecipe1 = Recipe(
        id: "recipe-alternate-steel-canister",
        input: Recipe.Ingredient(V2.Parts.steelIngot, amount: 3),
        output: Recipe.Ingredient(V2.Parts.emptyCanister, amount: 2),
        duration: 3,
        isDefault: false
    )
    
    static let emptyFluidTankRecipe = Recipe(
        id: "recipe-empty-fluid-tank",
        input: Recipe.Ingredient(V2.Parts.aluminumIngot, amount: 1),
        output: Recipe.Ingredient(V2.Parts.emptyFluidTank, amount: 1),
        duration: 1
    )
    
    // MARK: - Alien Remains
    static let hogProteinRecipe = Recipe(
        id: "recipe-hog-protein",
        input: Recipe.Ingredient(V2.Parts.hogRemains, amount: 1),
        output: Recipe.Ingredient(V2.Parts.alienProtein, amount: 1),
        duration: 3
    )
    
    static let hatcherProteinRecipe = Recipe(
        id: "recipe-hatcher-protein",
        input: Recipe.Ingredient(V2.Parts.hatcherRemains, amount: 1),
        output: Recipe.Ingredient(V2.Parts.alienProtein, amount: 1),
        duration: 3
    )
    
    static let stingerProteinRecipe = Recipe(
        id: "recipe-stinger-protein",
        input: Recipe.Ingredient(V2.Parts.stingerRemains, amount: 1),
        output: Recipe.Ingredient(V2.Parts.alienProtein, amount: 1),
        duration: 3
    )
    
    static let spitterProteinRecipe = Recipe(
        id: "recipe-spitter-protein",
        input: Recipe.Ingredient(V2.Parts.plasmaSpitterRemains, amount: 1),
        output: Recipe.Ingredient(V2.Parts.alienProtein, amount: 1),
        duration: 3
    )
    
    static let alienDNACapsuleRecipe = Recipe(
        id: "recipe-alien-dna-capsule",
        input: Recipe.Ingredient(V2.Parts.alienProtein, amount: 1),
        output: Recipe.Ingredient(V2.Parts.alienDNACapsule, amount: 1),
        duration: 6
    )
    
    // MARK: - Power Shards
    static let powerShard1Recipe = Recipe(
        id: "recipe-power-shard-1",
        input: Recipe.Ingredient(V2.Parts.bluePowerSlug, amount: 1),
        output: Recipe.Ingredient(V2.Parts.powerShard, amount: 1),
        duration: 8
    )
    
    static let powerShard2Recipe = Recipe(
        id: "recipe-power-shard-2",
        input: Recipe.Ingredient(V2.Parts.yellowPowerSlug, amount: 1),
        output: Recipe.Ingredient(V2.Parts.powerShard, amount: 2),
        duration: 12
    )
    
    static let powerShard5Recipe = Recipe(
        id: "recipe-power-shard-5",
        input: Recipe.Ingredient(V2.Parts.purplePowerSlug, amount: 1),
        output: Recipe.Ingredient(V2.Parts.powerShard, amount: 5),
        duration: 24
    )
    
    // MARK: - Ammunition
    static let ironRebarRecipe = Recipe(
        id: "recipe-iron-rebar",
        input: Recipe.Ingredient(V2.Parts.ironRod, amount: 1),
        output: Recipe.Ingredient(V2.Parts.ironRebar, amount: 1),
        duration: 4
    )
    
    // MARK: - FICSMAS
    static let ficsmasTreeBranchRecipe = Recipe(
        id: "recipe-ficsmas-tree-branch",
        input: Recipe.Ingredient(V2.Parts.ficsmasGift, amount: 1),
        output: Recipe.Ingredient(V2.Parts.ficsmasTreeBranch, amount: 1),
        duration: 6
    )
    
    static let candyCanePartRecipe = Recipe(
        id: "recipe-candy-cane",
        input: Recipe.Ingredient(V2.Parts.ficsmasGift, amount: 3),
        output: Recipe.Ingredient(V2.Parts.candyCanePart, amount: 1),
        duration: 12
    )
    
    static let ficsmasBowRecipe = Recipe(
        id: "recipe-ficsmas-bow",
        input: Recipe.Ingredient(V2.Parts.ficsmasGift, amount: 2),
        output: Recipe.Ingredient(V2.Parts.ficsmasBow, amount: 1),
        duration: 12
    )
    
    static let actualSnowRecipe = Recipe(
        id: "recipe-actual-snow",
        input: Recipe.Ingredient(V2.Parts.ficsmasGift, amount: 5),
        output: Recipe.Ingredient(V2.Parts.actualSnow, amount: 2),
        duration: 12
    )
    
    static let snowballRecipe = Recipe(
        id: "recipe-snowball",
        input: Recipe.Ingredient(V2.Parts.actualSnow, amount: 3),
        output: Recipe.Ingredient(V2.Parts.snowball, amount: 1),
        duration: 12
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
        spitterProteinRecipe,
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
