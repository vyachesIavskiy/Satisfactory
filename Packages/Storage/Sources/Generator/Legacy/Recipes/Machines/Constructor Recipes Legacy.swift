import StaticModels

private extension RecipeLegacy {
    init(
        id: String,
        name: String,
        input: Ingredient,
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            name: name,
            input: [input],
            output: [output],
            machines: [Legacy.Buildings.constructor.id],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension Legacy.Recipes {
    // Standard Parts
    static let ironPlateRecipe = RecipeLegacy(
        id: "iron-plate",
        name: "Iron Plate",
        input: .init(Legacy.Parts.ironIngot, amount: 3),
        output: .init(Legacy.Parts.ironPlate, amount: 2),
        duration: 6
    )

    static let ironRodRecipe = RecipeLegacy(
        id: "iron-rod",
        name: "Iron Rod",
        input: .init(Legacy.Parts.ironIngot, amount: 1),
        output: .init(Legacy.Parts.ironRod, amount: 1),
        duration: 4
    )

    static let ironRodRecipe1 = RecipeLegacy(
        id: "alternate-steel rod",
        name: "Alternate: Steel Rod",
        input: .init(Legacy.Parts.steelIngot, amount: 1),
        output: .init(Legacy.Parts.ironRod, amount: 4),
        duration: 5,
        isDefault: false
    )

    static let screwRecipe = RecipeLegacy(
        id: "screw",
        name: "Screw",
        input: .init(Legacy.Parts.ironRod, amount: 1),
        output: .init(Legacy.Parts.screw, amount: 4),
        duration: 6
    )

    static let screwRecipe1 = RecipeLegacy(
        id: "alternate-cast screw",
        name: "Alternate: Cast Screw",
        input: .init(Legacy.Parts.ironIngot, amount: 5),
        output: .init(Legacy.Parts.screw, amount: 20),
        duration: 24,
        isDefault: false
    )

    static let screwRecipe2 = RecipeLegacy(
        id: "alternate-steel screw",
        name: "Alternate: Steel Screw",
        input: .init(Legacy.Parts.steelBeam, amount: 1),
        output: .init(Legacy.Parts.screw, amount: 52),
        duration: 12,
        isDefault: false
    )

    static let copperSheetRecipe = RecipeLegacy(
        id: "copper-sheet",
        name: "Copper Sheet",
        input: .init(Legacy.Parts.copperIngot, amount: 2),
        output: .init(Legacy.Parts.copperSheet, amount: 1),
        duration: 6
    )

    static let steelBeamRecipe = RecipeLegacy(
        id: "steel-beam",
        name: "Steel Beam",
        input: .init(Legacy.Parts.steelIngot, amount: 4),
        output: .init(Legacy.Parts.steelBeam, amount: 1),
        duration: 4
    )

    static let steelPipeRecipe = RecipeLegacy(
        id: "steel-pipe",
        name: "Steel Pipe",
        input: .init(Legacy.Parts.steelIngot, amount: 3),
        output: .init(Legacy.Parts.steelPipe, amount: 2),
        duration: 6
    )

    static let aluminumCasingRecipe = RecipeLegacy(
        id: "aluminum-casing",
        name: "Aluminum Casing",
        input: .init(Legacy.Parts.aluminumIngot, amount: 3),
        output: .init(Legacy.Parts.aluminumCasing, amount: 2),
        duration: 2
    )

    // Electronics
    static let wireRecipe = RecipeLegacy(
        id: "wire",
        name: "Wire",
        input: .init(Legacy.Parts.copperIngot, amount: 1),
        output: .init(Legacy.Parts.wire, amount: 2),
        duration: 4
    )

    static let wireRecipe1 = RecipeLegacy(
        id: "alternate-iron wire",
        name: "Alternate: Iron Wire",
        input: .init(Legacy.Parts.ironIngot, amount: 5),
        output: .init(Legacy.Parts.wire, amount: 9),
        duration: 24,
        isDefault: false
    )

    static let wireRecipe2 = RecipeLegacy(
        id: "alternate-caterium wire",
        name: "Alternate: Caterium wire",
        input: .init(Legacy.Parts.cateriumIngot, amount: 1),
        output: .init(Legacy.Parts.wire, amount: 8),
        duration: 4,
        isDefault: false
    )

    static let cableRecipe = RecipeLegacy(
        id: "cable",
        name: "Cable",
        input: .init(Legacy.Parts.wire, amount: 2),
        output: .init(Legacy.Parts.cable, amount: 1),
        duration: 2
    )

    static let quickwireRecipe = RecipeLegacy(
        id: "quickwire",
        name: "Quickwire",
        input: .init(Legacy.Parts.cateriumIngot, amount: 1),
        output: .init(Legacy.Parts.quickwire, amount: 5),
        duration: 5
    )

    // Minerals
    static let concreteRecipe = RecipeLegacy(
        id: "concrete",
        name: "Concrete",
        input: .init(Legacy.Parts.limestone, amount: 3),
        output: .init(Legacy.Parts.concrete, amount: 1),
        duration: 4
    )

    static let quartzCrystalRecipe = RecipeLegacy(
        id: "quartz-crystal",
        name: "Quartz Crystal",
        input: .init(Legacy.Parts.rawQuartz, amount: 5),
        output: .init(Legacy.Parts.quartzCrystal, amount: 3),
        duration: 8
    )

    static let silicaRecipe = RecipeLegacy(
        id: "silica",
        name: "Silica",
        input: .init(Legacy.Parts.rawQuartz, amount: 3),
        output: .init(Legacy.Parts.silica, amount: 5),
        duration: 8
    )

    static let copperPowderRecipe = RecipeLegacy(
        id: "copper-powder",
        name: "Copper Powder",
        input: .init(Legacy.Parts.copperIngot, amount: 30),
        output: .init(Legacy.Parts.copperPowder, amount: 5),
        duration: 6
    )

    // Biomass
    static let biomassLeavesRecipe = RecipeLegacy(
        id: "biomass-(leaves)",
        name: "Biomass (Leaves)",
        input: .init(Legacy.Parts.leaves, amount: 10),
        output: .init(Legacy.Parts.biomass, amount: 5),
        duration: 5
    )

    static let biomassWoodRecipe = RecipeLegacy(
        id: "biomass-(wood)",
        name: "Biomass (Wood)",
        input: .init(Legacy.Parts.wood, amount: 4),
        output: .init(Legacy.Parts.biomass, amount: 20),
        duration: 4
    )

    static let biomassMyceliaRecipe = RecipeLegacy(
        id: "biomass-(mycelia)",
        name: "Biomass (Mycelia)",
        input: .init(Legacy.Parts.mycelia, amount: 1),
        output: .init(Legacy.Parts.biomass, amount: 10),
        duration: 4
    )

    static let biomassAlienProteinRecipe = RecipeLegacy(
        id: "biomass-(alien-protein)",
        name: "Biomass (Alien Protein)",
        input: .init(Legacy.Parts.alienProtein, amount: 1),
        output: .init(Legacy.Parts.biomass, amount: 100),
        duration: 4
    )

    static let hogProteinRecipe = RecipeLegacy(
        id: "hog-protein",
        name: "Hog Protein",
        input: .init(Legacy.Parts.hogRemains, amount: 1),
        output: .init(Legacy.Parts.alienProtein, amount: 1),
        duration: 3
    )

    static let plasmSpitterProteinRecipe = RecipeLegacy(
        id: "plasma-spitter-protein",
        name: "Plasma Spitter Protein",
        input: .init(Legacy.Parts.plasmaSpitterRemains, amount: 1),
        output: .init(Legacy.Parts.alienProtein, amount: 1),
        duration: 3
    )

    static let stingerProteinRecipe = RecipeLegacy(
        id: "stinger-protein",
        name: "Stinger Protein",
        input: .init(Legacy.Parts.stingerRemains, amount: 1),
        output: .init(Legacy.Parts.alienProtein, amount: 1),
        duration: 3
    )

    static let hatcherProteinRecipe = RecipeLegacy(
        id: "hatcher-protein",
        name: "Hatcher Protein",
        input: .init(Legacy.Parts.hatcherRemains, amount: 1),
        output: .init(Legacy.Parts.alienProtein, amount: 1),
        duration: 3
    )

    static let solidBiofuelRecipe = RecipeLegacy(
        id: "solid-biofuel",
        name: "Solid Biofuel",
        input: .init(Legacy.Parts.biomass, amount: 8),
        output: .init(Legacy.Parts.solidBiofuel, amount: 4),
        duration: 4
    )

    static let alienDNACapsuleRecipe = RecipeLegacy(
        id: "alien-dna-capsule",
        name: "Alien DNA Capsule",
        input: .init(Legacy.Parts.alienProtein, amount: 1),
        output: .init(Legacy.Parts.alienDNACapsule, amount: 1),
        duration: 6
    )

    // Raw Materials
    static let bioCoalRecipe = RecipeLegacy(
        id: "alternate-biocoal",
        name: "Alternate: Biocoal",
        input: .init(Legacy.Parts.biomass, amount: 5),
        output: .init(Legacy.Parts.coal, amount: 6),
        duration: 8,
        isDefault: false
    )

    static let charcoalRecipe = RecipeLegacy(
        id: "alternate-charcoal",
        name: "Alternate: Charcoal",
        input: .init(Legacy.Parts.wood, amount: 1),
        output: .init(Legacy.Parts.coal, amount: 10),
        duration: 4,
        isDefault: false
    )

    // Containers
    static let emptyCanisterRecipe = RecipeLegacy(
        id: "empty-canister",
        name: "Empty Canister",
        input: .init(Legacy.Parts.plastic, amount: 2),
        output: .init(Legacy.Parts.emptyCanister, amount: 4),
        duration: 4
    )

    static let emptyCanisterRecipe1 = RecipeLegacy(
        id: "alternate-steel canister",
        name: "Alternate: Steel Canister",
        input: .init(Legacy.Parts.steelIngot, amount: 3),
        output: .init(Legacy.Parts.emptyCanister, amount: 2),
        duration: 3,
        isDefault: false
    )

    static let emptyFluidTankRecipe = RecipeLegacy(
        id: "empty-fluid-tank",
        name: "Empty Fluid Tank",
        input: .init(Legacy.Parts.aluminumIngot, amount: 1),
        output: .init(Legacy.Parts.emptyFluidTank, amount: 1),
        duration: 1
    )

    // Consumed
    static let ironRebarRecipe = RecipeLegacy(
        id: "iron-rebar",
        name: "Iron Rebar",
        input: .init(Legacy.Parts.ironRod, amount: 1),
        output: .init(Legacy.Parts.ironRebar, amount: 1),
        duration: 4
    )

    static let colorCartridgeRecipe = RecipeLegacy(
        id: "color-cartridge",
        name: "Color Cartridge",
        input: .init(Legacy.Parts.flowerPetals, amount: 5),
        output: .init(Legacy.Parts.colorCartridge, amount: 10),
        duration: 8
    )

    // Power Shards
    static let powerShard1Recipe = RecipeLegacy(
        id: "power-shard-(1)",
        name: "Power Shard (1)",
        input: .init(Legacy.Parts.bluePowerSlug, amount: 1),
        output: .init(Legacy.Parts.powerShard, amount: 1),
        duration: 8
    )

    static let powerShard2Recipe = RecipeLegacy(
        id: "power-shard-(2)",
        name: "Power Shard (2)",
        input: .init(Legacy.Parts.yellowPowerSlug, amount: 1),
        output: .init(Legacy.Parts.powerShard, amount: 2),
        duration: 12
    )

    static let powerShard5Recipe = RecipeLegacy(
        id: "power-shard-(5)",
        name: "Power Shard (5)",
        input: .init(Legacy.Parts.purplePowerSlug, amount: 1),
        output: .init(Legacy.Parts.powerShard, amount: 5),
        duration: 24
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
        plasmSpitterProteinRecipe,
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
