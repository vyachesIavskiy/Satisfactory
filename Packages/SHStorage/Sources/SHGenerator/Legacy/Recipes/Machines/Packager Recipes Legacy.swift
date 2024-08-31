import SHModels
import SHStaticModels

extension Legacy.Recipes {
    // MARK: - Packaging
    static let packagedWaterRecipe = Recipe.Static.Legacy(
        id: "packaged-water",
        output: [
            .init(Legacy.Parts.packagedWater)
        ],
        input: [
            .init(Legacy.Parts.water),
            .init(Legacy.Parts.emptyCanister)
        ]
    )

    static let packagedOilRecipe = Recipe.Static.Legacy(
        id: "packaged-oil",
        output: [
            .init(Legacy.Parts.packagedOil)
        ],
        input: [
            .init(Legacy.Parts.crudeOil),
            .init(Legacy.Parts.emptyCanister)
        ]
    )

    static let packagedHeavyOilResidueRecipe = Recipe.Static.Legacy(
        id: "packaged-heavy-oil-residue",
        output: [
            .init(Legacy.Parts.packagedHeavyOilResidue)
        ],
        input: [
            .init(Legacy.Parts.heavyOilResidue),
            .init(Legacy.Parts.emptyCanister)
        ]
    )

    static let packagedLiquidBiofuelRecipe = Recipe.Static.Legacy(
        id: "packaged-liquid-biofuel",
        output: [
            .init(Legacy.Parts.packagedLiquidBiofuel)
        ],
        input: [
            .init(Legacy.Parts.liquidBiofuel),
            .init(Legacy.Parts.emptyCanister)
        ]
    )

    static let packagedFuelRecipe = Recipe.Static.Legacy(
        id: "packaged-fuel",
        output: [
            .init(Legacy.Parts.packagedFuel)
        ],
        input: [
            .init(Legacy.Parts.fuel),
            .init(Legacy.Parts.emptyCanister)
        ]
    )

    static let packagedTurbofuelRecipe = Recipe.Static.Legacy(
        id: "packaged-turbofuel",
        output: [
            .init(Legacy.Parts.packagedTurbofuel)
        ],
        input: [
            .init(Legacy.Parts.turbofuel),
            .init(Legacy.Parts.emptyCanister)
        ]
    )

    static let packagedAluminaSolutionRecipe = Recipe.Static.Legacy(
        id: "packaged-alumina-solution",
        output: [
            .init(Legacy.Parts.packagedAluminaSolution)
        ],
        input: [
            .init(Legacy.Parts.aluminaSolution),
            .init(Legacy.Parts.emptyCanister)
        ]
    )

    static let packagedSulfuricAcidRecipe = Recipe.Static.Legacy(
        id: "packaged-sulfuric-acid",
        output: [
            .init(Legacy.Parts.packagedSulfuricAcid)
        ],
        input: [
            .init(Legacy.Parts.sulfuricAcid),
            .init(Legacy.Parts.emptyCanister)
        ]
    )

    static let packagedNitrogenGasRecipe = Recipe.Static.Legacy(
        id: "packaged-nitrogen-gas",
        output: [
            .init(Legacy.Parts.packagedNitrogenGas)
        ],
        input: [
            .init(Legacy.Parts.nitrogenGas),
            .init(Legacy.Parts.emptyFluidTank)
        ]
    )

    static let packagedNitricAcidRecipe = Recipe.Static.Legacy(
        id: "packaged-nitric-acid",
        output: [
            .init(Legacy.Parts.packagedNitricAcid)
        ],
        input: [
            .init(Legacy.Parts.nitricAcid),
            .init(Legacy.Parts.emptyFluidTank)
        ]
    )

    // MARK: - Unpackaging
    static let unpackagedWaterRecipe = Recipe.Static.Legacy(
        id: "unpackaged-water",
        output: [
            .init(Legacy.Parts.water),
            .init(Legacy.Parts.emptyCanister)
        ],
        input: [
            .init(Legacy.Parts.packagedWater)
        ]
    )

    static let unpackagedOilRecipe = Recipe.Static.Legacy(
        id: "unpackaged-oil",
        output: [
            .init(Legacy.Parts.crudeOil),
            .init(Legacy.Parts.emptyCanister)
        ],
        input: [
            .init(Legacy.Parts.packagedOil)
        ]
    )

    static let unpackagedHeavyOilResidueRecipe = Recipe.Static.Legacy(
        id: "unpackaged-heavy-oil-residue",
        output: [
            .init(Legacy.Parts.heavyOilResidue),
            .init(Legacy.Parts.emptyCanister)
        ],
        input: [
            .init(Legacy.Parts.packagedHeavyOilResidue)
        ]
    )

    static let unpackagedLiquidBiofuelRecipe = Recipe.Static.Legacy(
        id: "unpackaged-liquid-biofuel",
        output: [
            .init(Legacy.Parts.liquidBiofuel),
            .init(Legacy.Parts.emptyCanister)
        ],
        input: [
            .init(Legacy.Parts.packagedLiquidBiofuel)
        ]
    )

    static let unpackagedFuelRecipe = Recipe.Static.Legacy(
        id: "unpackaged-fuel",
        output: [
            .init(Legacy.Parts.fuel),
            .init(Legacy.Parts.emptyCanister)
        ],
        input: [
            .init(Legacy.Parts.packagedFuel)
        ]
    )

    static let unpackagedTurbofuelRecipe = Recipe.Static.Legacy(
        id: "unpackaged-turbofuel",
        output: [
            .init(Legacy.Parts.turbofuel),
            .init(Legacy.Parts.emptyCanister)
        ],
        input: [
            .init(Legacy.Parts.packagedTurbofuel)
        ]
    )

    static let unpackagedAluminaSolutionRecipe = Recipe.Static.Legacy(
        id: "unpackaged-alumina-solution",
        output: [
            .init(Legacy.Parts.aluminaSolution),
            .init(Legacy.Parts.emptyCanister)
        ],
        input: [
            .init(Legacy.Parts.packagedAluminaSolution)
        ]
    )

    static let unpackagedSulfuricAcidRecipe = Recipe.Static.Legacy(
        id: "unpackaged-sulfuric-acid",
        output: [
            .init(Legacy.Parts.sulfuricAcid),
            .init(Legacy.Parts.emptyCanister)
        ],
        input: [
            .init(Legacy.Parts.packagedSulfuricAcid)
        ]
    )

    static let unpackagedNitrogenGasRecipe = Recipe.Static.Legacy(
        id: "unpackaged-nitrogen-gas",
        output: [
            .init(Legacy.Parts.nitrogenGas),
            .init(Legacy.Parts.emptyFluidTank)
        ],
        input: [
            .init(Legacy.Parts.packagedNitrogenGas)
        ]
    )

    static let unpackagedNitricAcidRecipe = Recipe.Static.Legacy(
        id: "unpackaged-nitric-acid",
        output: [
            .init(Legacy.Parts.nitricAcid),
            .init(Legacy.Parts.emptyFluidTank)
        ],
        input: [
            .init(Legacy.Parts.packagedNitricAcid)
        ]
    )

    static let packagerRecipes = [
        // Packaging
        packagedWaterRecipe,
        packagedOilRecipe,
        packagedHeavyOilResidueRecipe,
        packagedLiquidBiofuelRecipe,
        packagedFuelRecipe,
        packagedTurbofuelRecipe,
        packagedAluminaSolutionRecipe,
        packagedSulfuricAcidRecipe,
        packagedNitrogenGasRecipe,
        packagedNitricAcidRecipe,
        
        // Unpackaging
        unpackagedWaterRecipe,
        unpackagedOilRecipe,
        unpackagedHeavyOilResidueRecipe,
        unpackagedLiquidBiofuelRecipe,
        unpackagedFuelRecipe,
        unpackagedTurbofuelRecipe,
        unpackagedAluminaSolutionRecipe,
        unpackagedSulfuricAcidRecipe,
        unpackagedNitrogenGasRecipe,
        unpackagedNitricAcidRecipe
    ]
}
