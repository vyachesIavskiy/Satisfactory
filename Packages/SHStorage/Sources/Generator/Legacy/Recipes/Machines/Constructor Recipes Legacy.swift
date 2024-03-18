import Models
import StaticModels

private extension Recipe.Static.Legacy {
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
    static let ironPlateRecipe = Recipe.Static.Legacy(
        id: "iron-plate",
        name: "Iron Plate",
        input: .init(Legacy.Parts.ironIngot, amount: 3),
        output: .init(Legacy.Parts.ironPlate, amount: 2),
        duration: 6
    )

    static let ironRodRecipe = Recipe.Static.Legacy(
        id: "iron-rod",
        name: "Iron Rod",
        input: .init(Legacy.Parts.ironIngot, amount: 1),
        output: .init(Legacy.Parts.ironRod, amount: 1),
        duration: 4
    )

    static let ironRodRecipe1 = Recipe.Static.Legacy(
        id: "alternate-steel rod",
        name: "Alternate: Steel Rod",
        input: .init(Legacy.Parts.steelIngot, amount: 1),
        output: .init(Legacy.Parts.ironRod, amount: 4),
        duration: 5,
        isDefault: false
    )

    static let screwRecipe = Recipe.Static.Legacy(
        id: "screw",
        name: "Screw",
        input: .init(Legacy.Parts.ironRod, amount: 1),
        output: .init(Legacy.Parts.screw, amount: 4),
        duration: 6
    )

    static let screwRecipe1 = Recipe.Static.Legacy(
        id: "alternate-cast screw",
        name: "Alternate: Cast Screw",
        input: .init(Legacy.Parts.ironIngot, amount: 5),
        output: .init(Legacy.Parts.screw, amount: 20),
        duration: 24,
        isDefault: false
    )

    static let screwRecipe2 = Recipe.Static.Legacy(
        id: "alternate-steel screw",
        name: "Alternate: Steel Screw",
        input: .init(Legacy.Parts.steelBeam, amount: 1),
        output: .init(Legacy.Parts.screw, amount: 52),
        duration: 12,
        isDefault: false
    )

    static let copperSheetRecipe = Recipe.Static.Legacy(
        id: "copper-sheet",
        name: "Copper Sheet",
        input: .init(Legacy.Parts.copperIngot, amount: 2),
        output: .init(Legacy.Parts.copperSheet, amount: 1),
        duration: 6
    )

    static let steelBeamRecipe = Recipe.Static.Legacy(
        id: "steel-beam",
        name: "Steel Beam",
        input: .init(Legacy.Parts.steelIngot, amount: 4),
        output: .init(Legacy.Parts.steelBeam, amount: 1),
        duration: 4
    )

    static let steelPipeRecipe = Recipe.Static.Legacy(
        id: "steel-pipe",
        name: "Steel Pipe",
        input: .init(Legacy.Parts.steelIngot, amount: 3),
        output: .init(Legacy.Parts.steelPipe, amount: 2),
        duration: 6
    )

    static let aluminumCasingRecipe = Recipe.Static.Legacy(
        id: "aluminum-casing",
        name: "Aluminum Casing",
        input: .init(Legacy.Parts.aluminumIngot, amount: 3),
        output: .init(Legacy.Parts.aluminumCasing, amount: 2),
        duration: 2
    )

    // Electronics
    static let wireRecipe = Recipe.Static.Legacy(
        id: "wire",
        name: "Wire",
        input: .init(Legacy.Parts.copperIngot, amount: 1),
        output: .init(Legacy.Parts.wire, amount: 2),
        duration: 4
    )

    static let wireRecipe1 = Recipe.Static.Legacy(
        id: "alternate-iron wire",
        name: "Alternate: Iron Wire",
        input: .init(Legacy.Parts.ironIngot, amount: 5),
        output: .init(Legacy.Parts.wire, amount: 9),
        duration: 24,
        isDefault: false
    )

    static let wireRecipe2 = Recipe.Static.Legacy(
        id: "alternate-caterium wire",
        name: "Alternate: Caterium wire",
        input: .init(Legacy.Parts.cateriumIngot, amount: 1),
        output: .init(Legacy.Parts.wire, amount: 8),
        duration: 4,
        isDefault: false
    )

    static let cableRecipe = Recipe.Static.Legacy(
        id: "cable",
        name: "Cable",
        input: .init(Legacy.Parts.wire, amount: 2),
        output: .init(Legacy.Parts.cable, amount: 1),
        duration: 2
    )

    static let quickwireRecipe = Recipe.Static.Legacy(
        id: "quickwire",
        name: "Quickwire",
        input: .init(Legacy.Parts.cateriumIngot, amount: 1),
        output: .init(Legacy.Parts.quickwire, amount: 5),
        duration: 5
    )

    // Minerals
    static let concreteRecipe = Recipe.Static.Legacy(
        id: "concrete",
        name: "Concrete",
        input: .init(Legacy.Parts.limestone, amount: 3),
        output: .init(Legacy.Parts.concrete, amount: 1),
        duration: 4
    )

    static let quartzCrystalRecipe = Recipe.Static.Legacy(
        id: "quartz-crystal",
        name: "Quartz Crystal",
        input: .init(Legacy.Parts.rawQuartz, amount: 5),
        output: .init(Legacy.Parts.quartzCrystal, amount: 3),
        duration: 8
    )

    static let silicaRecipe = Recipe.Static.Legacy(
        id: "silica",
        name: "Silica",
        input: .init(Legacy.Parts.rawQuartz, amount: 3),
        output: .init(Legacy.Parts.silica, amount: 5),
        duration: 8
    )

    static let copperPowderRecipe = Recipe.Static.Legacy(
        id: "copper-powder",
        name: "Copper Powder",
        input: .init(Legacy.Parts.copperIngot, amount: 30),
        output: .init(Legacy.Parts.copperPowder, amount: 5),
        duration: 6
    )

    // Biomass
    static let biomassLeavesRecipe = Recipe.Static.Legacy(
        id: "biomass-(leaves)",
        name: "Biomass (Leaves)",
        input: .init(Legacy.Parts.leaves, amount: 10),
        output: .init(Legacy.Parts.biomass, amount: 5),
        duration: 5
    )

    static let biomassWoodRecipe = Recipe.Static.Legacy(
        id: "biomass-(wood)",
        name: "Biomass (Wood)",
        input: .init(Legacy.Parts.wood, amount: 4),
        output: .init(Legacy.Parts.biomass, amount: 20),
        duration: 4
    )

    static let biomassMyceliaRecipe = Recipe.Static.Legacy(
        id: "biomass-(mycelia)",
        name: "Biomass (Mycelia)",
        input: .init(Legacy.Parts.mycelia, amount: 1),
        output: .init(Legacy.Parts.biomass, amount: 10),
        duration: 4
    )

    static let biomassAlienProteinRecipe = Recipe.Static.Legacy(
        id: "biomass-(alien-protein)",
        name: "Biomass (Alien Protein)",
        input: .init(Legacy.Parts.alienProtein, amount: 1),
        output: .init(Legacy.Parts.biomass, amount: 100),
        duration: 4
    )

    static let hogProteinRecipe = Recipe.Static.Legacy(
        id: "hog-protein",
        name: "Hog Protein",
        input: .init(Legacy.Parts.hogRemains, amount: 1),
        output: .init(Legacy.Parts.alienProtein, amount: 1),
        duration: 3
    )

    static let plasmSpitterProteinRecipe = Recipe.Static.Legacy(
        id: "plasma-spitter-protein",
        name: "Plasma Spitter Protein",
        input: .init(Legacy.Parts.plasmaSpitterRemains, amount: 1),
        output: .init(Legacy.Parts.alienProtein, amount: 1),
        duration: 3
    )

    static let stingerProteinRecipe = Recipe.Static.Legacy(
        id: "stinger-protein",
        name: "Stinger Protein",
        input: .init(Legacy.Parts.stingerRemains, amount: 1),
        output: .init(Legacy.Parts.alienProtein, amount: 1),
        duration: 3
    )

    static let hatcherProteinRecipe = Recipe.Static.Legacy(
        id: "hatcher-protein",
        name: "Hatcher Protein",
        input: .init(Legacy.Parts.hatcherRemains, amount: 1),
        output: .init(Legacy.Parts.alienProtein, amount: 1),
        duration: 3
    )

    static let solidBiofuelRecipe = Recipe.Static.Legacy(
        id: "solid-biofuel",
        name: "Solid Biofuel",
        input: .init(Legacy.Parts.biomass, amount: 8),
        output: .init(Legacy.Parts.solidBiofuel, amount: 4),
        duration: 4
    )

    static let alienDNACapsuleRecipe = Recipe.Static.Legacy(
        id: "alien-dna-capsule",
        name: "Alien DNA Capsule",
        input: .init(Legacy.Parts.alienProtein, amount: 1),
        output: .init(Legacy.Parts.alienDNACapsule, amount: 1),
        duration: 6
    )

    // Raw Materials
    static let bioCoalRecipe = Recipe.Static.Legacy(
        id: "alternate-biocoal",
        name: "Alternate: Biocoal",
        input: .init(Legacy.Parts.biomass, amount: 5),
        output: .init(Legacy.Parts.coal, amount: 6),
        duration: 8,
        isDefault: false
    )

    static let charcoalRecipe = Recipe.Static.Legacy(
        id: "alternate-charcoal",
        name: "Alternate: Charcoal",
        input: .init(Legacy.Parts.wood, amount: 1),
        output: .init(Legacy.Parts.coal, amount: 10),
        duration: 4,
        isDefault: false
    )

    // Containers
    static let emptyCanisterRecipe = Recipe.Static.Legacy(
        id: "empty-canister",
        name: "Empty Canister",
        input: .init(Legacy.Parts.plastic, amount: 2),
        output: .init(Legacy.Parts.emptyCanister, amount: 4),
        duration: 4
    )

    static let emptyCanisterRecipe1 = Recipe.Static.Legacy(
        id: "alternate-steel canister",
        name: "Alternate: Steel Canister",
        input: .init(Legacy.Parts.steelIngot, amount: 3),
        output: .init(Legacy.Parts.emptyCanister, amount: 2),
        duration: 3,
        isDefault: false
    )

    static let emptyFluidTankRecipe = Recipe.Static.Legacy(
        id: "empty-fluid-tank",
        name: "Empty Fluid Tank",
        input: .init(Legacy.Parts.aluminumIngot, amount: 1),
        output: .init(Legacy.Parts.emptyFluidTank, amount: 1),
        duration: 1
    )

    // Consumed
    static let ironRebarRecipe = Recipe.Static.Legacy(
        id: "iron-rebar",
        name: "Iron Rebar",
        input: .init(Legacy.Parts.ironRod, amount: 1),
        output: .init(Legacy.Parts.ironRebar, amount: 1),
        duration: 4
    )

    static let colorCartridgeRecipe = Recipe.Static.Legacy(
        id: "color-cartridge",
        name: "Color Cartridge",
        input: .init(Legacy.Parts.flowerPetals, amount: 5),
        output: .init(Legacy.Parts.colorCartridge, amount: 10),
        duration: 8
    )

    // Power Shards
    static let powerShard1Recipe = Recipe.Static.Legacy(
        id: "power-shard-(1)",
        name: "Power Shard (1)",
        input: .init(Legacy.Parts.bluePowerSlug, amount: 1),
        output: .init(Legacy.Parts.powerShard, amount: 1),
        duration: 8
    )

    static let powerShard2Recipe = Recipe.Static.Legacy(
        id: "power-shard-(2)",
        name: "Power Shard (2)",
        input: .init(Legacy.Parts.yellowPowerSlug, amount: 1),
        output: .init(Legacy.Parts.powerShard, amount: 2),
        duration: 12
    )

    static let powerShard5Recipe = Recipe.Static.Legacy(
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
