import StaticModels

private extension Recipe {
    init(
        id: String,
        input: Ingredient,
        output: Ingredient,
        duration: Int
    ) {
        self.init(
            id: id,
            inputs: [input],
            output: output,
            machines: [V2.Buildings.nuclearPowerPlant],
            duration: duration
        )
    }
}

extension V2.Recipes {
    // MARK: - Nuclear Power Plant
    static let uraniumWasteRecipe = Recipe(
        id: "recipe-uranium-waste",
        input: Recipe.Ingredient(V2.Parts.uraniumFuelRod, amount: 1),
        output: Recipe.Ingredient(V2.Parts.uraniumWaste, amount: 50),
        duration: 300
    )
    
    static let plutoniumWasteRecipe = Recipe(
        id: "recipe-plutonium-waste",
        input: Recipe.Ingredient(V2.Parts.plutoniumFuelRod, amount: 1),
        output: Recipe.Ingredient(V2.Parts.plutoniumWaste, amount: 10),
        duration: 600
    )
    
    static let nuclearPowerPlantRecipes = [
        uraniumWasteRecipe,
        plutoniumWasteRecipe
    ]
}
