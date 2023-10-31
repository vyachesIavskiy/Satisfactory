import StaticModels

private extension Recipe {
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
            machines: [V2.Buildings.particleAccelerator],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Nuclear
    static let plutoniumPelletRecipe = Recipe(
        id: "recipe-plutonium-pellet",
        inputs: [
            Recipe.Ingredient(V2.Parts.nonFissileUranium, amount: 100),
            Recipe.Ingredient(V2.Parts.uraniumWaste, amount: 25)
        ],
        output: Recipe.Ingredient(V2.Parts.plutoniumPellet, amount: 30),
        duration: 60
    )
    
    static let encasedPlutoniumCellRecipe1 = Recipe(
        id: "recipe-alternate-instant-plutonium-cell",
        inputs: [
            Recipe.Ingredient(V2.Parts.nonFissileUranium, amount: 150),
            Recipe.Ingredient(V2.Parts.aluminumCasing, amount: 20)
        ],
        output: Recipe.Ingredient(V2.Parts.encasedPlutoniumCell, amount: 20),
        duration: 120,
        isDefault: false
    )
    
    // MARK: - Quantum Technology
    static let nuclearPastaRecipe = Recipe(
        id: "recipe-nuclear-pasta",
        inputs: [
            Recipe.Ingredient(V2.Parts.copperPowder, amount: 200),
            Recipe.Ingredient(V2.Parts.pressureConversionCube, amount: 1)
        ],
        output: Recipe.Ingredient(V2.Parts.nuclearPasta, amount: 1),
        duration: 120
    )
    
    static let particleAcceleratorRecipes = [
        plutoniumPelletRecipe,
        encasedPlutoniumCellRecipe1,
        nuclearPastaRecipe
    ]
}
