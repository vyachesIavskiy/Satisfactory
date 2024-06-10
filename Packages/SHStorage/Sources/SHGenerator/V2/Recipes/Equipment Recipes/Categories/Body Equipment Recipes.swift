import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(id: String, inputs: [Ingredient], equipment: Equipment.Static) {
        self.init(
            id: id,
            inputs: inputs,
            output: Ingredient(equipment, amount: 1),
            byproducts: [],
            machine: nil,
            manualCrafting: [V2.Buildings.equipmentWorkshop],
            duration: 0
        )
    }
}

extension V2.Recipes {
    static let hazmatSuitRecipe = Recipe.Static(
        id: "recipe-hazmat-suit",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.alcladAluminumSheet, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.fabric, amount: 50)
        ],
        equipment: V2.Equipment.hazmatSuit
    )
    
    static let bodyEquipmentRecipes = [
        hazmatSuitRecipe
    ]
}
