import SHModels
import SHStaticModels

extension Legacy.Recipes {
    // Ingots
    static let ironIngotRecipe2 = Recipe.Static.Legacy(
        id: "alternate-pure-iron-ingot",
        output: [
            .init(Legacy.Parts.ironIngot)
        ],
        input: [
            .init(Legacy.Parts.ironOre),
            .init(Legacy.Parts.water)
        ]
    )

    static let copperIngotRecipe2 = Recipe.Static.Legacy(
        id: "alternate-pure-copper-ingot",
        output: [
            .init(Legacy.Parts.copperIngot)
        ],
        input: [
            .init(Legacy.Parts.copperOre),
            .init(Legacy.Parts.water)
        ]
    )

    static let cateriumIngotRecipe1 = Recipe.Static.Legacy(
        id: "alternate-pure-caterium-ingot",
        output: [
            .init(Legacy.Parts.cateriumIngot)
        ],
        input: [
            .init(Legacy.Parts.cateriumOre),
            .init(Legacy.Parts.water)
        ]
    )

    // Minerals
    static let concreteRecipe3 = Recipe.Static.Legacy(
        id: "alternate-wet-concrete",
        output: [
            .init(Legacy.Parts.concrete)
        ],
        input: [
            .init(Legacy.Parts.limestone),
            .init(Legacy.Parts.water)
        ]
    )

    static let quartzCrystalRecipe1 = Recipe.Static.Legacy(
        id: "alternate-pure-quartz-crystal",
        output: [
            .init(Legacy.Parts.quartzCrystal)
        ],
        input: [
            .init(Legacy.Parts.rawQuartz),
            .init(Legacy.Parts.water)
        ]
    )

    // Biomass
    static let fabricRecipe1 = Recipe.Static.Legacy(
        id: "alternate-polyester-fabric",
        output: [
            .init(Legacy.Parts.fabric)
        ],
        input: [
            .init(Legacy.Parts.polymerResin),
            .init(Legacy.Parts.water)
        ]
    )

    // Standard Parts
    static let copperSheetRecipe1 = Recipe.Static.Legacy(
        id: "alternate-steamed-copper-sheet",
        output: [
            .init(Legacy.Parts.copperSheet)
        ],
        input: [
            .init(Legacy.Parts.copperIngot),
            .init(Legacy.Parts.water)
        ]
    )

    // Electronics
    static let cableRecipe3 = Recipe.Static.Legacy(
        id: "alternate-coated-cable",
        output: [
            .init(Legacy.Parts.cable)
        ],
        input: [
            .init(Legacy.Parts.wire),
            .init(Legacy.Parts.heavyOilResidue)
        ]
    )

    // Advanced Refinement
    static let aluminumScrapRecipe = Recipe.Static.Legacy(
        id: "aluminum-scrap",
        output: [
            .init(Legacy.Parts.aluminumScrap),
            .init(Legacy.Parts.water)
        ],
        input: [
            .init(Legacy.Parts.aluminaSolution),
            .init(Legacy.Parts.coal)
        ]
    )

    static let aluminumScrapRecipe1 = Recipe.Static.Legacy(
        id: "alternate-electrode---aluminumscrap",
        output: [
            .init(Legacy.Parts.aluminumScrap),
            .init(Legacy.Parts.water)
        ],
        input: [
            .init(Legacy.Parts.aluminaSolution),
            .init(Legacy.Parts.petroleumCoke)
        ]
    )

    static let aluminaSolutionRecipe = Recipe.Static.Legacy(
        id: "alumina-solution",
        output: [
            .init(Legacy.Parts.aluminaSolution),
            .init(Legacy.Parts.silica)
        ],
        input: [
            .init(Legacy.Parts.bauxite),
            .init(Legacy.Parts.water)
        ]
    )

    static let aluminaSolutionRecipe1 = Recipe.Static.Legacy(
        id: "alternate-sloppy-alumina",
        output: [
            .init(Legacy.Parts.aluminaSolution)
        ],
        input: [
            .init(Legacy.Parts.bauxite),
            .init(Legacy.Parts.water)
        ]
    )

    static let sulfuricAcidRecipe = Recipe.Static.Legacy(
        id: "sulfuric-acid",
        output: [
            .init(Legacy.Parts.sulfuricAcid)
        ],
        input: [
            .init(Legacy.Parts.sulfur),
            .init(Legacy.Parts.water)
        ]
    )

    // Oil Products
    static let plasticRecipe = Recipe.Static.Legacy(
        id: "plastic",
        output: [
            .init(Legacy.Parts.plastic),
            .init(Legacy.Parts.heavyOilResidue)
        ],
        input: [
            .init(Legacy.Parts.crudeOil)
        ]
    )

    static let residualPlasticRecipe = Recipe.Static.Legacy(
        id: "residual-plastic",
        output: [
            .init(Legacy.Parts.plastic)
        ],
        input: [
            .init(Legacy.Parts.polymerResin),
            .init(Legacy.Parts.water)
        ]
    )

    static let plasticRecipe1 = Recipe.Static.Legacy(
        id: "alternate-recycled-plastic",
        output: [
            .init(Legacy.Parts.plastic)
        ],
        input: [
            .init(Legacy.Parts.rubber),
            .init(Legacy.Parts.fuel)
        ]
    )

    static let rubberRecipe = Recipe.Static.Legacy(
        id: "rubber",
        output: [
            .init(Legacy.Parts.rubber),
            .init(Legacy.Parts.heavyOilResidue)
        ],
        input: [
            .init(Legacy.Parts.crudeOil)
        ]
    )

    static let residualRubberRecipe = Recipe.Static.Legacy(
        id: "residual-rubber",
        output: [
            .init(Legacy.Parts.rubber)
        ],
        input: [
            .init(Legacy.Parts.polymerResin),
            .init(Legacy.Parts.water)
        ]
    )

    static let rubberRecipe1 = Recipe.Static.Legacy(
        id: "alternate-recycled-rubber",
        output: [
            .init(Legacy.Parts.rubber)
        ],
        input: [
            .init(Legacy.Parts.plastic),
            .init(Legacy.Parts.fuel)
        ]
    )

    static let petroleumCokeRecipe = Recipe.Static.Legacy(
        id: "petroleum-coke",
        output: [
            .init(Legacy.Parts.petroleumCoke)
        ],
        input: [
            .init(Legacy.Parts.heavyOilResidue)
        ]
    )

    static let polymerResinRecipe1 = Recipe.Static.Legacy(
        id: "alternate-polymer-resin",
        output: [
            .init(Legacy.Parts.polymerResin),
            .init(Legacy.Parts.heavyOilResidue)
        ],
        input: [
            .init(Legacy.Parts.crudeOil)
        ]
    )

    static let heavyOilResidueRecipe1 = Recipe.Static.Legacy(
        id: "alternate-heavy-oil-residue",
        output: [
            .init(Legacy.Parts.heavyOilResidue),
            .init(Legacy.Parts.polymerResin)
        ],
        input: [
            .init(Legacy.Parts.crudeOil)
        ]
    )

    // Fuel
    static let fuelRecipe = Recipe.Static.Legacy(
        id: "fuel",
        output: [
            .init(Legacy.Parts.fuel),
            .init(Legacy.Parts.polymerResin)
        ],
        input: [
            .init(Legacy.Parts.crudeOil)
        ]
    )

    static let residualFuelRecipe = Recipe.Static.Legacy(
        id: "residual-fuel",
        output: [
            .init(Legacy.Parts.fuel)
        ],
        input: [
            .init(Legacy.Parts.heavyOilResidue)
        ]
    )

    static let fuelRecipe1 = Recipe.Static.Legacy(
        id: "alternate-diluted-packaged-fuel",
        output: [
            .init(Legacy.Parts.fuel)
        ],
        input: [
            .init(Legacy.Parts.heavyOilResidue),
            .init(Legacy.Parts.packagedWater)
        ]
    )

    static let liquidBiofuelRecipe = Recipe.Static.Legacy(
        id: "liquid-biofuel",
        output: [
            .init(Legacy.Parts.liquidBiofuel)
        ],
        input: [
            .init(Legacy.Parts.solidBiofuel),
            .init(Legacy.Parts.water)
        ]
    )

    static let turbofuelRecipe = Recipe.Static.Legacy(
        id: "turbofuel",
        output: [
            .init(Legacy.Parts.turbofuel)
        ],
        input: [
            .init(Legacy.Parts.fuel),
            .init(Legacy.Parts.compactedCoal)
        ]
    )

    static let turbofuelRecipe1 = Recipe.Static.Legacy(
        id: "alternate-turbo-heavy-fuel",
        output: [
            .init(Legacy.Parts.turbofuel)
        ],
        input: [
            .init(Legacy.Parts.heavyOilResidue),
            .init(Legacy.Parts.compactedCoal)
        ]
    )
    
    // Cosumed
    static let smokelessPowderRecipe = Recipe.Static.Legacy(
        id: "smokeless-powder",
        output: [
            .init(Legacy.Parts.smokelessPowder)
        ],
        input: [
            .init(Legacy.Parts.blackPowder),
            .init(Legacy.Parts.heavyOilResidue)
        ]
    )

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
