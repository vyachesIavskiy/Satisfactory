import Models
import StaticModels

private extension Recipe.Static {
    init(id: String, inputs: [Ingredient], building: Building.Static) {
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
    static let nuclearPowerPlantRecipe = Recipe.Static(
        id: "recipe-nuclear-power-plant",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.concrete, amount: 250),
            Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 25),
            Recipe.Static.Ingredient(V2.Parts.supercomputer, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 100),
            Recipe.Static.Ingredient(V2.Parts.alcladAluminumSheet, amount: 100)
        ],
        building: V2.Buildings.nuclearPowerPlant
    )
    
    static let generatorsRecipes = [
        nuclearPowerPlantRecipe
    ]
}
