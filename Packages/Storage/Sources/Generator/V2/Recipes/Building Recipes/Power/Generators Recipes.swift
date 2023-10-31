import StaticModels

private extension Recipe {
    init(id: String, inputs: [Ingredient], building: Building) {
        self.init(
            id: id,
            inputs: inputs,
            output: Ingredient(building, amount: 1),
            machines: [],
            duration: 0
        )
    }
}

extension V2.Recipes {
    static let nuclearPowerPlantRecipe = Recipe(
        id: "recipe-nuclear-power-plant",
        inputs: [
            Recipe.Ingredient(V2.Parts.concrete, amount: 250),
            Recipe.Ingredient(V2.Parts.heavyModularFrame, amount: 25),
            Recipe.Ingredient(V2.Parts.supercomputer, amount: 5),
            Recipe.Ingredient(V2.Parts.cable, amount: 100),
            Recipe.Ingredient(V2.Parts.alcladAluminumSheet, amount: 100)
        ],
        building: V2.Buildings.nuclearPowerPlant
    )
    
    static let generatorsRecipes = [
        nuclearPowerPlantRecipe
    ]
}
