import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(id: String, inputs: [Ingredient], building: Building.Static) {
        self.init(
            id: id,
            inputs: inputs,
            output: Ingredient(building, amount: 1),
            machine: nil,
            manualCrafting: [],
            duration: 0
        )
    }
}

extension V2.Recipes {
    static let smelterRecipe = Recipe.Static(
        id: "recipe-smelter",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironRod, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 8)
        ],
        building: V2.Buildings.smelter
    )
    
    static let foundryRecipe = Recipe.Static(
        id: "recipe-foundry",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.concrete, amount: 20)
        ],
        building: V2.Buildings.foundry
    )
    
    static let smeltersRecipes = [
        smelterRecipe,
        foundryRecipe
    ]
}
