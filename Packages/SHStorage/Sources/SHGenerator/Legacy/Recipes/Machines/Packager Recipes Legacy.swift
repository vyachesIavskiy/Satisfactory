import SHModels
import SHStaticModels

private extension Recipe.Static.Legacy {
    init(
        id: String,
        name: String,
        input: [Ingredient],
        output: [Ingredient],
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            name: name,
            input: input,
            output: output,
            machines: [Legacy.Buildings.packager.id],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension Legacy.Recipes {
    // MARK: - Packaging
    static let packagedWaterRecipe = Recipe.Static.Legacy(
        id: "packaged-water",
        name: "Packaged Water",
        input: [
            .init(Legacy.Parts.water, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.packagedWater, amount: 2)
        ],
        duration: 2
    )

    static let packagedOilRecipe = Recipe.Static.Legacy(
        id: "packaged-oil",
        name: "Packaged Oil",
        input: [
            .init(Legacy.Parts.crudeOil, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.packagedOil, amount: 2)
        ],
        duration: 4
    )

    static let packagedHeavyOilResidueRecipe = Recipe.Static.Legacy(
        id: "packaged-heavy-oil-residue",
        name: "Packaged Heavy Oil Residue",
        input: [
            .init(Legacy.Parts.heavyOilResidue, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.packagedHeavyOilResidue, amount: 2)
        ],
        duration: 4
    )

    static let packagedLiquidBiofuelRecipe = Recipe.Static.Legacy(
        id: "packaged-liquid-biofuel",
        name: "Packaged Liquid Biofuel",
        input: [
            .init(Legacy.Parts.liquidBiofuel, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.packagedLiquidBiofuel, amount: 2)
        ],
        duration: 3
    )

    static let packagedFuelRecipe = Recipe.Static.Legacy(
        id: "packaged-fuel",
        name: "Packaged Fuel",
        input: [
            .init(Legacy.Parts.fuel, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.packagedFuel, amount: 2)
        ],
        duration: 3
    )

    static let packagedTurbofuelRecipe = Recipe.Static.Legacy(
        id: "packaged-turbofuel",
        name: "Packaged Turbofuel",
        input: [
            .init(Legacy.Parts.turbofuel, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.packagedTurbofuel, amount: 2)
        ],
        duration: 6
    )

    static let packagedAluminaSolutionRecipe = Recipe.Static.Legacy(
        id: "packaged-alumina-solution",
        name: "Packaged Alumina Solution",
        input: [
            .init(Legacy.Parts.aluminaSolution, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.packagedAluminaSolution, amount: 2)
        ],
        duration: 1
    )

    static let packagedSulfuricAcidRecipe = Recipe.Static.Legacy(
        id: "packaged-sulfuric-acid",
        name: "Packaged Sulfuric Acid",
        input: [
            .init(Legacy.Parts.sulfuricAcid, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.packagedSulfuricAcid, amount: 2)
        ],
        duration: 3
    )

    static let packagedNitrogenGasRecipe = Recipe.Static.Legacy(
        id: "packaged-nitrogen-gas",
        name: "Packaged Nitrogen Gas",
        input: [
            .init(Legacy.Parts.nitrogenGas, amount: 4),
            .init(Legacy.Parts.emptyFluidTank, amount: 1)
        ],
        output: [
            .init(Legacy.Parts.packagedNitrogenGas, amount: 1)
        ],
        duration: 1
    )

    static let packagedNitricAcidRecipe = Recipe.Static.Legacy(
        id: "packaged-nitric-acid",
        name: "Packaged Nitric Acid",
        input: [
            .init(Legacy.Parts.nitricAcid, amount: 1),
            .init(Legacy.Parts.emptyFluidTank, amount: 1)
        ],
        output: [
            .init(Legacy.Parts.packagedNitricAcid, amount: 1)
        ],
        duration: 2
    )

    // MARK: - Unpackaging
    static let unpackagedWaterRecipe = Recipe.Static.Legacy(
        id: "unpackaged-water",
        name: "Unpackaged Water",
        input: [
            .init(Legacy.Parts.packagedWater, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.water, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        duration: 1
    )

    static let unpackagedOilRecipe = Recipe.Static.Legacy(
        id: "unpackaged-oil",
        name: "Unpackaged Oil",
        input: [
            .init(Legacy.Parts.packagedOil, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.crudeOil, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        duration: 2
    )

    static let unpackagedHeavyOilResidueRecipe = Recipe.Static.Legacy(
        id: "unpackaged-heavy-oil-residue",
        name: "Unpackaged Heavy Oil Residue",
        input: [
            .init(Legacy.Parts.packagedHeavyOilResidue, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.heavyOilResidue, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        duration: 6
    )

    static let unpackagedLiquidBiofuelRecipe = Recipe.Static.Legacy(
        id: "unpackaged-liquid-biofuel",
        name: "Unpackaged Liquid Biofuel",
        input: [
            .init(Legacy.Parts.packagedLiquidBiofuel, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.liquidBiofuel, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        duration: 2
    )

    static let unpackagedFuelRecipe = Recipe.Static.Legacy(
        id: "unpackaged-fuel",
        name: "Unpackaged Fuel",
        input: [
            .init(Legacy.Parts.packagedFuel, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.fuel, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        duration: 2
    )

    static let unpackagedTurbofuelRecipe = Recipe.Static.Legacy(
        id: "unpackaged-turbofuel",
        name: "Unpackaged Turbofuel",
        input: [
            .init(Legacy.Parts.packagedTurbofuel, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.turbofuel, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        duration: 6
    )

    static let unpackagedAluminaSolutionRecipe = Recipe.Static.Legacy(
        id: "unpackaged-alumina-solution",
        name: "Unpackaged Alumina Solution",
        input: [
            .init(Legacy.Parts.packagedAluminaSolution, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.aluminaSolution, amount: 2),
            .init(Legacy.Parts.emptyCanister, amount: 2)
        ],
        duration: 1
    )

    static let unpackagedSulfuricAcidRecipe = Recipe.Static.Legacy(
        id: "unpackaged-sulfuric-acid",
        name: "Unpackaged Sulfuric Acid",
        input: [
            .init(Legacy.Parts.packagedSulfuricAcid, amount: 1)
        ],
        output: [
            .init(Legacy.Parts.sulfuricAcid, amount: 1),
            .init(Legacy.Parts.emptyCanister, amount: 1)
        ],
        duration: 1
    )

    static let unpackagedNitrogenGasRecipe = Recipe.Static.Legacy(
        id: "unpackaged-nitrogen-gas",
        name: "Unpackaged Nitrogen Gas",
        input: [
            .init(Legacy.Parts.packagedNitrogenGas, amount: 1)
        ],
        output: [
            .init(Legacy.Parts.nitrogenGas, amount: 4),
            .init(Legacy.Parts.emptyFluidTank, amount: 1)
        ],
        duration: 1
    )

    static let unpackagedNitricAcidRecipe = Recipe.Static.Legacy(
        id: "unpackaged-nitric-acid",
        name: "Unpackaged Nitric Acid",
        input: [
            .init(Legacy.Parts.packagedNitricAcid, amount: 1)
        ],
        output: [
            .init(Legacy.Parts.nitricAcid, amount: 1),
            .init(Legacy.Parts.emptyFluidTank, amount: 1)
        ],
        duration: 3
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