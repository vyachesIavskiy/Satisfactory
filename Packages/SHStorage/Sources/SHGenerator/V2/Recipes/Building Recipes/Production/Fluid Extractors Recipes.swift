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
            duration: 0,
            electricityConsumption: ElectricityConsumption(min: 0, max: 0)
        )
    }
}

extension V2.Recipes {
    static let waterExtractorRecipe = Recipe.Static(
        id: "recipe-water-extractor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperSheet, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 10)
        ],
        building: V2.Buildings.waterExctractor
    )
    
    static let oilExtractorRecipe = Recipe.Static(
        id: "recipe-oil-extractor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 60)
        ],
        building: V2.Buildings.oilExctractor
    )
    
    static let resourceWellPressurizerRecipe = Recipe.Static(
        id: "recipe-resource-well-pressurizer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 200),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 50)
        ],
        building: V2.Buildings.resourceWellPressurizer
    )
    
    static let resourceWellExtractorRecipe = Recipe.Static(
        id: "recipe-resource-well-extractor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.steelBeam, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 10)
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
