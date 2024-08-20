import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(id: String, inputs: [Ingredient], equipment: Equipment.Static) {
        self.init(
            id: id,
            inputs: inputs,
            output: Ingredient(equipment, amount: 1),
            machine: nil,
            manualCrafting: [V2.Buildings.equipmentWorkshop],
            duration: 0,
            electricityConsumption: ElectricityConsumption(min: 0, max: 0)
        )
    }
}

extension V2.Recipes {
    static let gasMaskRecipe = Recipe.Static(
        id: "recipe-gas-mask",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 100),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 100),
            Recipe.Static.Ingredient(V2.Parts.fabric, amount: 100)
        ],
        equipment: V2.Equipment.gasMask
    )
    
    static let headEquipmentRecipes = [
        gasMaskRecipe
    ]
}
