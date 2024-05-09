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
    static let craftBenchRecipe = Recipe.Static(
        id: "recipe-craft-bench",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.ironRod, amount: 3)
        ],
        building: V2.Buildings.craftBench
    )
    
    static let equipmentWorkshopRecipe = Recipe.Static(
        id: "recipe-equipment-workshop",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.ironRod, amount: 4)
        ],
        building: V2.Buildings.equipmentWorkshop
    )
    
    static let workstationsRecipes = [
        craftBenchRecipe,
        equipmentWorkshopRecipe
    ]
}
