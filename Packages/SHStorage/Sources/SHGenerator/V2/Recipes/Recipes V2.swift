import SHModels
import SHStaticModels

extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        byproducts: [Ingredient]? = nil,
        machine: Building.Static?,
        duration: Double,
        powerConsumption: Recipe.Static.PowerConsumption,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            output: output,
            byproducts: byproducts,
            inputs: inputs,
            machineID: machine?.id,
            duration: duration,
            powerConsumption: powerConsumption,
            isDefault: isDefault
        )
    }
}

extension Recipe.Static.Ingredient {
    init(_ part: Part.Static, amount: Double) {
        self.init(partID: part.id, amount: amount)
    }
}

extension V2 {
    enum Recipes {
        static let all =
        machinesRecipes
    }
}
