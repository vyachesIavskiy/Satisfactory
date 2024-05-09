import Models
import StaticModels

private extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        byproduct: Ingredient,
        duration: Int
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            byproducts: [byproduct],
            machines: [V2.Buildings.packager],
            duration: duration
        )
    }
    
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            byproducts: [],
            machines: [V2.Buildings.packager],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Packaging
    static let packagedWaterRecipe = Recipe.Static(
        id: "recipe-packaged-water",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.water, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.packagedWater, amount: 2),
        duration: 2
    )
    
    static let packagedOilRecipe = Recipe.Static(
        id: "recipe-packaged-oil",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.crudeOil, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.packagedOil, amount: 2),
        duration: 4
    )
    
    static let packagedHeavyOilResidueRecipe = Recipe.Static(
        id: "recipe-packaged-heavy-oil-residue",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.heavyOilResidue, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.packagedHeavyOilResidue, amount: 2),
        duration: 4
    )
    
    static let packagedFuelRecipe = Recipe.Static(
        id: "recipe-packaged-fuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.fuel, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.packagedFuel, amount: 2),
        duration: 3
    )
    
    static let packagedLiquidBiofuelRecipe = Recipe.Static(
        id: "recipe-packaged-liquid-biofuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.liquidBiofuel, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.packagedLiquidBiofuel, amount: 2),
        duration: 3
    )
    
    static let packagedTurbofuelRecipe = Recipe.Static(
        id: "recipe-packaged-turbofuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.turbofuel, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.packagedTurbofuel, amount: 2),
        duration: 6
    )
    
    static let packagedAluminaSolutionRecipe = Recipe.Static(
        id: "recipe-packaged-alumina-solution",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.aluminaSolution, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.packagedAluminaSolution, amount: 2),
        duration: 1
    )
    
    static let packagedSulfuricAcidRecipe = Recipe.Static(
        id: "recipe-packaged-sulfuric-acid",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.sulfuricAcid, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.packagedSulfuricAcid, amount: 2),
        duration: 3
    )
    
    static let packagedNitrogenGasRecipe = Recipe.Static(
        id: "recipe-packaged-nitrogen-gas",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nitrogenGas, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.emptyFluidTank, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.packagedNitrogenGas, amount: 1),
        duration: 1
    )
    
    static let packagedNitricAcidRecipe = Recipe.Static(
        id: "recipe-packaged-nitric-acid",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nitricAcid, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.emptyFluidTank, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.packagedNitricAcid, amount: 1),
        duration: 2
    )
    
    // MARK: - Unpackaging
    static let unpackagedWaterRecipe = Recipe.Static(
        id: "recipe-unpackaged-water",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.packagedWater, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.water, amount: 2),
        byproduct: Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2),
        duration: 1
    )
    
    static let unpackagedOilRecipe = Recipe.Static(
        id: "recipe-unpackaged-oil",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.packagedOil, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.crudeOil, amount: 2),
        byproduct: Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2),
        duration: 2
    )
    
    static let unpackagedHeavyOilResidueRecipe = Recipe.Static(
        id: "recipe-unpackaged-heavy-oil-residue",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.packagedHeavyOilResidue, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.heavyOilResidue, amount: 2),
        byproduct: Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2),
        duration: 6
    )
    
    static let unpackagedFuelRecipe = Recipe.Static(
        id: "recipe-unpackaged-fuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.packagedFuel, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.fuel, amount: 2),
        byproduct: Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2),
        duration: 2
    )
    
    static let unpackagedLiquidBiofuelRecipe = Recipe.Static(
        id: "recipe-unpackaged-liquid-biofuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.packagedLiquidBiofuel, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.liquidBiofuel, amount: 2),
        byproduct: Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2),
        duration: 2
    )
    
    static let unpackagedTurbofuelRecipe = Recipe.Static(
        id: "recipe-unpackaged-turbofuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.packagedTurbofuel, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.turbofuel, amount: 2),
        byproduct: Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2),
        duration: 6
    )
    
    static let unpackagedAluminaSolutionRecipe = Recipe.Static(
        id: "recipe-unpackaged-alumina-solution",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.packagedAluminaSolution, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.aluminaSolution, amount: 2),
        byproduct: Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 2),
        duration: 1
    )
    
    static let unpackagedSulfuricAcidRecipe = Recipe.Static(
        id: "recipe-unpackaged-sulfuric-acid",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.packagedSulfuricAcid, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.sulfuricAcid, amount: 1),
        byproduct: Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 1),
        duration: 1
    )
    
    static let unpackagedNitrogenGasRecipe = Recipe.Static(
        id: "recipe-unpackaged-nitrogen-gas",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.packagedNitrogenGas, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.nitrogenGas, amount: 4),
        byproduct: Recipe.Static.Ingredient(V2.Parts.emptyFluidTank, amount: 1),
        duration: 1
    )
    
    static let unpackagedNitricAcidRecipe = Recipe.Static(
        id: "recipe-unpackaged-nitric-acid",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.packagedNitricAcid, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.nitricAcid, amount: 1),
        byproduct: Recipe.Static.Ingredient(V2.Parts.emptyFluidTank, amount: 1),
        duration: 3
    )
    
    static let packagerRecipes = [
        packagedWaterRecipe,
        packagedOilRecipe,
        packagedHeavyOilResidueRecipe,
        packagedFuelRecipe,
        packagedLiquidBiofuelRecipe,
        packagedTurbofuelRecipe,
        packagedAluminaSolutionRecipe,
        packagedSulfuricAcidRecipe,
        packagedNitrogenGasRecipe,
        packagedNitricAcidRecipe,
        unpackagedWaterRecipe,
        unpackagedOilRecipe,
        unpackagedHeavyOilResidueRecipe,
        unpackagedFuelRecipe,
        unpackagedLiquidBiofuelRecipe,
        unpackagedTurbofuelRecipe,
        unpackagedAluminaSolutionRecipe,
        unpackagedSulfuricAcidRecipe,
        unpackagedNitrogenGasRecipe,
        unpackagedNitricAcidRecipe
    ]
}
