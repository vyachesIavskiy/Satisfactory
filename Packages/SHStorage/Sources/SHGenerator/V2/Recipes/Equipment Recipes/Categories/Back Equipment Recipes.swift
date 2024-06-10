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
    static let parachuteRecipe = Recipe.Static(
        id: "recipe-parachute",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.fabric, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 5)
        ],
        equipment: V2.Equipment.parachute
    )
    
    static let jetpackRecipe = Recipe.Static(
        id: "recipe-jetpack",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 5)
        ],
        equipment: V2.Equipment.jetpack
    )
    
    static let hoverpackRecipe = Recipe.Static(
        id: "recipe-hoverpack",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 8),
            Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.computer, amount: 8),
            Recipe.Static.Ingredient(V2.Parts.alcladAluminumSheet, amount: 40)
        ],
        equipment: V2.Equipment.hoverPack
    )
    
    static let backEquipmentRecipes = [
        parachuteRecipe,
        jetpackRecipe,
        hoverpackRecipe
    ]
}
