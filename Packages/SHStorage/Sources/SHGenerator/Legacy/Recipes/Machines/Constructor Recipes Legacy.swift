import SHModels
import SHStaticModels

private extension Recipe.Static.Legacy {
    init(id: String, output: Ingredient, input: Ingredient) {
        self.init(id: id, output: [output], input: [input])
    }
}

extension Legacy.Recipes {
    // Standard Parts
    static let ironPlateRecipe = Recipe.Static.Legacy(
        id: "iron-plate",
        output: .init(Legacy.Parts.ironPlate),
        input: .init(Legacy.Parts.ironIngot)
    )

    static let ironRodRecipe = Recipe.Static.Legacy(
        id: "iron-rod",
        output: .init(Legacy.Parts.ironRod),
        input: .init(Legacy.Parts.ironIngot)
    )

    static let ironRodRecipe1 = Recipe.Static.Legacy(
        id: "alternate-steel-rod",
        output: .init(Legacy.Parts.ironRod),
        input: .init(Legacy.Parts.steelIngot)
    )

    static let screwRecipe = Recipe.Static.Legacy(
        id: "screw",
        output: .init(Legacy.Parts.screw),
        input: .init(Legacy.Parts.ironRod)
    )

    static let screwRecipe1 = Recipe.Static.Legacy(
        id: "alternate-cast-screw",
        output: .init(Legacy.Parts.screw),
        input: .init(Legacy.Parts.ironIngot)
    )

    static let screwRecipe2 = Recipe.Static.Legacy(
        id: "alternate-steel-screw",
        output: .init(Legacy.Parts.screw),
        input: .init(Legacy.Parts.steelBeam)
    )

    static let copperSheetRecipe = Recipe.Static.Legacy(
        id: "copper-sheet",
        output: .init(Legacy.Parts.copperSheet),
        input: .init(Legacy.Parts.copperIngot)
    )

    static let steelBeamRecipe = Recipe.Static.Legacy(
        id: "steel-beam",
        output: .init(Legacy.Parts.steelBeam),
        input: .init(Legacy.Parts.steelIngot)
    )

    static let steelPipeRecipe = Recipe.Static.Legacy(
        id: "steel-pipe",
        output: .init(Legacy.Parts.steelPipe),
        input: .init(Legacy.Parts.steelIngot)
    )

    static let aluminumCasingRecipe = Recipe.Static.Legacy(
        id: "aluminum-casing",
        output: .init(Legacy.Parts.aluminumCasing),
        input: .init(Legacy.Parts.aluminumIngot)
    )

    // Electronics
    static let wireRecipe = Recipe.Static.Legacy(
        id: "wire",
        output: .init(Legacy.Parts.wire),
        input: .init(Legacy.Parts.copperIngot)
    )

    static let wireRecipe1 = Recipe.Static.Legacy(
        id: "alternate-iron-wire",
        output: .init(Legacy.Parts.wire),
        input: .init(Legacy.Parts.ironIngot)
    )

    static let wireRecipe2 = Recipe.Static.Legacy(
        id: "alternate-caterium-wire",
        output: .init(Legacy.Parts.wire),
        input: .init(Legacy.Parts.cateriumIngot)
    )

    static let cableRecipe = Recipe.Static.Legacy(
        id: "cable",
        output: .init(Legacy.Parts.cable),
        input: .init(Legacy.Parts.wire)
    )

    static let quickwireRecipe = Recipe.Static.Legacy(
        id: "quickwire",
        output: .init(Legacy.Parts.quickwire),
        input: .init(Legacy.Parts.cateriumIngot)
    )

    // Minerals
    static let concreteRecipe = Recipe.Static.Legacy(
        id: "concrete",
        output: .init(Legacy.Parts.concrete),
        input: .init(Legacy.Parts.limestone)
    )

    static let quartzCrystalRecipe = Recipe.Static.Legacy(
        id: "quartz-crystal",
        output: .init(Legacy.Parts.quartzCrystal),
        input: .init(Legacy.Parts.rawQuartz)
    )

    static let silicaRecipe = Recipe.Static.Legacy(
        id: "silica",
        output: .init(Legacy.Parts.silica),
        input: .init(Legacy.Parts.rawQuartz)
    )

    static let copperPowderRecipe = Recipe.Static.Legacy(
        id: "copper-powder",
        output: .init(Legacy.Parts.copperPowder),
        input: .init(Legacy.Parts.copperIngot)
    )

    // Biomass
    static let biomassLeavesRecipe = Recipe.Static.Legacy(
        id: "biomass-(leaves)",
        output: .init(Legacy.Parts.biomass),
        input: .init(Legacy.Parts.leaves)
    )

    static let biomassWoodRecipe = Recipe.Static.Legacy(
        id: "biomass-(wood)",
        output: .init(Legacy.Parts.biomass),
        input: .init(Legacy.Parts.wood)
    )

    static let biomassMyceliaRecipe = Recipe.Static.Legacy(
        id: "biomass-(mycelia)",
        output: .init(Legacy.Parts.biomass),
        input: .init(Legacy.Parts.mycelia)
    )

    static let biomassAlienProteinRecipe = Recipe.Static.Legacy(
        id: "biomass-(alien-protein)",
        output: .init(Legacy.Parts.biomass),
        input: .init(Legacy.Parts.alienProtein)
    )

    static let hogProteinRecipe = Recipe.Static.Legacy(
        id: "hog-protein",
        output: .init(Legacy.Parts.alienProtein),
        input: .init(Legacy.Parts.hogRemains)
    )

    static let plasmaSpitterProteinRecipe = Recipe.Static.Legacy(
        id: "plasma-spitter-protein",
        output: .init(Legacy.Parts.alienProtein),
        input: .init(Legacy.Parts.plasmaSpitterRemains)
    )

    static let stingerProteinRecipe = Recipe.Static.Legacy(
        id: "stinger-protein",
        output: .init(Legacy.Parts.alienProtein),
        input: .init(Legacy.Parts.stingerRemains)
    )

    static let hatcherProteinRecipe = Recipe.Static.Legacy(
        id: "hatcher-protein",
        output: .init(Legacy.Parts.alienProtein),
        input: .init(Legacy.Parts.hatcherRemains)
    )

    static let solidBiofuelRecipe = Recipe.Static.Legacy(
        id: "solid-biofuel",
        output: .init(Legacy.Parts.solidBiofuel),
        input: .init(Legacy.Parts.biomass)
    )

    static let alienDNACapsuleRecipe = Recipe.Static.Legacy(
        id: "alien-dna-capsule",
        output: .init(Legacy.Parts.alienDNACapsule),
        input: .init(Legacy.Parts.alienProtein)
    )

    // Raw Materials
    static let bioCoalRecipe = Recipe.Static.Legacy(
        id: "alternate-biocoal",
        output: .init(Legacy.Parts.coal),
        input: .init(Legacy.Parts.biomass)
    )

    static let charcoalRecipe = Recipe.Static.Legacy(
        id: "alternate-charcoal",
        output: .init(Legacy.Parts.coal),
        input: .init(Legacy.Parts.wood)
    )

    // Containers
    static let emptyCanisterRecipe = Recipe.Static.Legacy(
        id: "empty-canister",
        output: .init(Legacy.Parts.emptyCanister),
        input: .init(Legacy.Parts.plastic)
    )

    static let emptyCanisterRecipe1 = Recipe.Static.Legacy(
        id: "alternate-steel-canister",
        output: .init(Legacy.Parts.emptyCanister),
        input: .init(Legacy.Parts.steelIngot)
    )

    static let emptyFluidTankRecipe = Recipe.Static.Legacy(
        id: "empty-fluid-tank",
        output: .init(Legacy.Parts.emptyFluidTank),
        input: .init(Legacy.Parts.aluminumIngot)
    )

    // Consumed
    static let ironRebarRecipe = Recipe.Static.Legacy(
        id: "iron-rebar",
        output: .init(Legacy.Parts.ironRebar),
        input: .init(Legacy.Parts.ironRod)
    )

    static let colorCartridgeRecipe = Recipe.Static.Legacy(
        id: "color-cartridge",
        output: .init(Legacy.Parts.colorCartridge),
        input: .init(Legacy.Parts.flowerPetals)
    )

    // Power Shards
    static let powerShard1Recipe = Recipe.Static.Legacy(
        id: "power-shard-(1)",
        output: .init(Legacy.Parts.powerShard),
        input: .init(Legacy.Parts.bluePowerSlug)
    )

    static let powerShard2Recipe = Recipe.Static.Legacy(
        id: "power-shard-(2)",
        output: .init(Legacy.Parts.powerShard),
        input: .init(Legacy.Parts.yellowPowerSlug)
    )

    static let powerShard5Recipe = Recipe.Static.Legacy(
        id: "power-shard-(5)",
        output: .init(Legacy.Parts.powerShard),
        input: .init(Legacy.Parts.purplePowerSlug)
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
        biomassLeavesRecipe,
        biomassWoodRecipe,
        biomassMyceliaRecipe,
        biomassAlienProteinRecipe,
        hogProteinRecipe,
        plasmaSpitterProteinRecipe,
        stingerProteinRecipe,
        hatcherProteinRecipe,
        solidBiofuelRecipe,
        alienDNACapsuleRecipe,
        bioCoalRecipe,
        charcoalRecipe,
        emptyCanisterRecipe,
        emptyCanisterRecipe1,
        emptyFluidTankRecipe,
        ironRebarRecipe,
        colorCartridgeRecipe,
        powerShard1Recipe,
        powerShard2Recipe,
        powerShard5Recipe,
    ]
}
