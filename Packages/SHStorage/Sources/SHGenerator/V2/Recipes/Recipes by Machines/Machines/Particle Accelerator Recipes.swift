import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true,
        manuallyCraftable: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            machine: V2.Buildings.constructor,
            manualCrafting: (isDefault && manuallyCraftable) ? [V2.Buildings.craftBench] : [],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Nuclear
    static let plutoniumPelletRecipe = Recipe.Static(
        id: "recipe-plutonium-pellet",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nonFissileUranium, amount: 100),
            Recipe.Static.Ingredient(V2.Parts.uraniumWaste, amount: 25)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.plutoniumPellet, amount: 30),
        duration: 60
    )
    
    static let encasedPlutoniumCellRecipe1 = Recipe.Static(
        id: "recipe-alternate-instant-plutonium-cell",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nonFissileUranium, amount: 150),
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 20)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.encasedPlutoniumCell, amount: 20),
        duration: 120,
        isDefault: false
    )
    
    // MARK: - Quantum Technology
    static let nuclearPastaRecipe = Recipe.Static(
        id: "recipe-nuclear-pasta",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperPowder, amount: 200),
            Recipe.Static.Ingredient(V2.Parts.pressureConversionCube, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.nuclearPasta, amount: 1),
        duration: 120,
        manuallyCraftable: false
    )
    
    static let particleAcceleratorRecipes = [
        plutoniumPelletRecipe,
        encasedPlutoniumCellRecipe1,
        nuclearPastaRecipe
    ]
}
