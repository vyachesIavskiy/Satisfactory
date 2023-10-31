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
    static let smelterRecipe = Recipe(
        id: "recipe-smelter",
        inputs: [
            Recipe.Ingredient(V2.Parts.ironRod, amount: 5),
            Recipe.Ingredient(V2.Parts.wire, amount: 8)
        ],
        building: V2.Buildings.smelter
    )
    
    static let foundryRecipe = Recipe(
        id: "recipe-foundry",
        inputs: [
            Recipe.Ingredient(V2.Parts.modularFrame, amount: 10),
            Recipe.Ingredient(V2.Parts.rotor, amount: 10),
            Recipe.Ingredient(V2.Parts.concrete, amount: 20)
        ],
        building: V2.Buildings.foundry
    )
    
    static let smeltersRecipes = [
        smelterRecipe,
        foundryRecipe
    ]
}
