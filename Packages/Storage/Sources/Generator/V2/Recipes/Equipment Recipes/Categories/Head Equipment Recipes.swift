import StaticModels

private extension Recipe {
    init(id: String, inputs: [Ingredient], equipment: Equipment) {
        self.init(
            id: id,
            inputs: inputs,
            output: Ingredient(equipment, amount: 1),
            machines: [V2.Buildings.equipmentWorkshop],
            duration: 0
        )
    }
}

extension V2.Recipes {
    static let gasMaskRecipe = Recipe(
        id: "recipe-gas-mask",
        inputs: [
            Recipe.Ingredient(V2.Parts.rubber, amount: 100),
            Recipe.Ingredient(V2.Parts.plastic, amount: 100),
            Recipe.Ingredient(V2.Parts.fabric, amount: 100)
        ],
        equipment: V2.Equipment.gasMask
    )
    
    static let headEquipmentRecipes = [
        gasMaskRecipe
    ]
}
