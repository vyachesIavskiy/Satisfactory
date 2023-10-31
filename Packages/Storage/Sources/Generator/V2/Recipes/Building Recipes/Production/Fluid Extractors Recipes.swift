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
    static let waterExtractorRecipe = Recipe(
        id: "recipe-water-extractor",
        inputs: [
            Recipe.Ingredient(V2.Parts.copperSheet, amount: 20),
            Recipe.Ingredient(V2.Parts.reinforcedIronPlate, amount: 10),
            Recipe.Ingredient(V2.Parts.rotor, amount: 10)
        ],
        building: V2.Buildings.waterExctractor
    )
    
    static let oilExtractorRecipe = Recipe(
        id: "recipe-oil-extractor",
        inputs: [
            Recipe.Ingredient(V2.Parts.motor, amount: 15),
            Recipe.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 20),
            Recipe.Ingredient(V2.Parts.cable, amount: 60)
        ],
        building: V2.Buildings.oilExctractor
    )
    
    static let resourceWellPressurizerRecipe = Recipe(
        id: "recipe-resource-well-pressurizer",
        inputs: [
            Recipe.Ingredient(V2.Parts.wire, amount: 200),
            Recipe.Ingredient(V2.Parts.rubber, amount: 50),
            Recipe.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 50),
            Recipe.Ingredient(V2.Parts.motor, amount: 50)
        ],
        building: V2.Buildings.resourceWellPressurizer
    )
    
    static let resourceWellExtractorRecipe = Recipe(
        id: "recipe-resource-well-extractor",
        inputs: [
            Recipe.Ingredient(V2.Parts.steelBeam, amount: 10),
            Recipe.Ingredient(V2.Parts.plastic, amount: 10)
        ],
        building: V2.Buildings.resourceWellExtractor
    )
    
    static let fluidExtractorsRecipes = [
        waterExtractorRecipe,
        oilExtractorRecipe,
        resourceWellPressurizerRecipe,
        resourceWellExtractorRecipe
    ]
}
