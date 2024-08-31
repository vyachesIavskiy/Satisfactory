import SHModels
import SHStaticModels

extension Legacy.Recipes {
    // MARK: - Industrial Parts
    static let coolingSystemRecipe = Recipe.Static.Legacy(
        id: "cooling-system",
        output: [
            .init(Legacy.Parts.coolingSystem)
        ],
        input: [
            .init(Legacy.Parts.heatSink),
            .init(Legacy.Parts.rubber),
            .init(Legacy.Parts.water),
            .init(Legacy.Parts.nitrogenGas)
        ]
    )

    static let coolingSystemRecipe1 = Recipe.Static.Legacy(
        id: "alternate-cooling-device",
        output: [
            .init(Legacy.Parts.coolingSystem)
        ],
        input: [
            .init(Legacy.Parts.heatSink),
            .init(Legacy.Parts.motor),
            .init(Legacy.Parts.nitrogenGas)
        ]
    )

    static let fusedModularFrameRecipe = Recipe.Static.Legacy(
        id: "fused-modular-frame",
        output: [
            .init(Legacy.Parts.fusedModularFrame)
        ],
        input: [
            .init(Legacy.Parts.heavyModularFrame),
            .init(Legacy.Parts.aluminumCasing),
            .init(Legacy.Parts.nitrogenGas)
        ]
    )

    static let fusedModularFrameRecipe1 = Recipe.Static.Legacy(
        id: "alternate-heat-fused-frame",
        output: [
            .init(Legacy.Parts.fusedModularFrame)
        ],
        input: [
            .init(Legacy.Parts.heavyModularFrame),
            .init(Legacy.Parts.aluminumIngot),
            .init(Legacy.Parts.nitricAcid),
            .init(Legacy.Parts.fuel)
        ]
    )

    static let batteryRecipe = Recipe.Static.Legacy(
        id: "battery",
        output: [
            .init(Legacy.Parts.battery),
            .init(Legacy.Parts.water)
        ],
        input: [
            .init(Legacy.Parts.sulfuricAcid),
            .init(Legacy.Parts.aluminaSolution),
            .init(Legacy.Parts.aluminumCasing)
        ]
    )

    // Fuel
    static let fuelRecipe2 = Recipe.Static.Legacy(
        id: "alternate-diluted-fuel",
        output: [
            .init(Legacy.Parts.fuel)
        ],
        input: [
            .init(Legacy.Parts.heavyOilResidue),
            .init(Legacy.Parts.water)
        ]
    )

    static let turbofuelRecipe2 = Recipe.Static.Legacy(
        id: "alternate-turbo-blend-fuel",
        output: [
            .init(Legacy.Parts.turbofuel)
        ],
        input: [
            .init(Legacy.Parts.fuel),
            .init(Legacy.Parts.heavyOilResidue),
            .init(Legacy.Parts.sulfur),
            .init(Legacy.Parts.petroleumCoke)
        ]
    )

    // Nuclear
    static let nonFissileUraniumRecipe = Recipe.Static.Legacy(
        id: "non-fissile-uranium",
        output: [
            .init(Legacy.Parts.nonFissileUranium),
            .init(Legacy.Parts.water)
        ],
        input: [
            .init(Legacy.Parts.uraniumWaste),
            .init(Legacy.Parts.silica),
            .init(Legacy.Parts.nitricAcid),
            .init(Legacy.Parts.sulfuricAcid)
        ]
    )

    static let nonFissileUraniumRecipe1 = Recipe.Static.Legacy(
        id: "alternate-fertile-uranium",
        output: [
            .init(Legacy.Parts.nonFissileUranium),
            .init(Legacy.Parts.water)
        ],
        input: [
            .init(Legacy.Parts.uranium),
            .init(Legacy.Parts.uraniumWaste),
            .init(Legacy.Parts.nitricAcid),
            .init(Legacy.Parts.sulfuricAcid)
        ]
    )

    static let encasedUraniumCellRecipe = Recipe.Static.Legacy(
        id: "encased-uranium-cell",
        output: [
            .init(Legacy.Parts.encasedUraniumCell),
            .init(Legacy.Parts.sulfuricAcid)
        ],
        input: [
            .init(Legacy.Parts.uranium),
            .init(Legacy.Parts.concrete),
            .init(Legacy.Parts.sulfuricAcid)
        ]
    )

    // Andvanced Refinement
    static let nitricAcidRecipe = Recipe.Static.Legacy(
        id: "nitric-acid",
        output: [
            .init(Legacy.Parts.nitricAcid)
        ],
        input: [
            .init(Legacy.Parts.nitrogenGas),
            .init(Legacy.Parts.water),
            .init(Legacy.Parts.ironPlate)
        ]
    )

    static let aluminumScrapRecipe2 = Recipe.Static.Legacy(
        id: "alternate-instant-scrap",
        output: [
            .init(Legacy.Parts.aluminumScrap),
            .init(Legacy.Parts.water)
        ],
        input: [
            .init(Legacy.Parts.bauxite),
            .init(Legacy.Parts.coal),
            .init(Legacy.Parts.sulfuricAcid),
            .init(Legacy.Parts.water)
        ]
    )

    static let blenderRecipes = [
        // Industrial parts
        coolingSystemRecipe,
        coolingSystemRecipe1,
        fusedModularFrameRecipe,
        fusedModularFrameRecipe1,
        batteryRecipe,
        
        // Fuel
        fuelRecipe2,
        turbofuelRecipe2,
        
        // Nuclear
        nonFissileUraniumRecipe,
        nonFissileUraniumRecipe1,
        encasedUraniumCellRecipe,
        
        // Advanced Refinement
        nitricAcidRecipe,
        aluminumScrapRecipe2
    ]
}
