import SHModels
import SHStaticModels

extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        byproducts: [Ingredient]? = nil,
        machine: Building.Static?,
        manualCrafting: [Building.Static],
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            byproducts: byproducts,
            machineID: machine?.id,
            manualCraftingIDs: manualCrafting.map(\.id),
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension Recipe.Static.Ingredient {
    init(_ part: Part.Static, amount: Double) {
        self.init(itemID: part.id, amount: amount)
    }
    
    init(_ equipment: Equipment.Static, amount: Double) {
        self.init(itemID: equipment.id, amount: amount)
    }
    
    init(_ building: Building.Static, amount: Double) {
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
