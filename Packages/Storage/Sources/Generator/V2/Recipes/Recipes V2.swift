import StaticModels
import Models

extension StaticModels.Recipe {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        byproducts: [Ingredient]? = nil,
        machines: [StaticModels.Building],
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            byproducts: byproducts,
            machineIDs: machines.map(\.id),
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension StaticModels.Recipe.Ingredient {
    init(_ part: StaticModels.Part, amount: Double) {
        self.init(itemID: part.id, amount: amount)
    }
    
    init(_ equipment: StaticModels.Equipment, amount: Double) {
        self.init(itemID: equipment.id, amount: amount)
    }
    
    init(_ building: StaticModels.Building, amount: Double) {
        self.init(itemID: building.id, amount: amount)
    }
}

extension V2 {
    enum Recipes {
        static let all =
        machinesRecipes +
        equipmentRecipes +
        buildingsRecipes
    }
}
