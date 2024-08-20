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
            powerConsumption: PowerConsumption(min: 0, max: 0)
        )
    }
}

extension V2.Recipes {
    static let bladeRunnersRecipe = Recipe.Static(
        id: "recipe-blade-runners",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.silica, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 3)
        ],
        equipment: V2.Equipment.bladeRunners
    )
    
    static let legsEquipmentRecipes = [
        bladeRunnersRecipe
    ]
}
