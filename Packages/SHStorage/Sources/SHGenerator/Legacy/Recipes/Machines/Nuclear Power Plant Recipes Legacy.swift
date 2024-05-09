import Models
import StaticModels

private extension Recipe.Static.Legacy {
    init(
        id: String,
        name: String,
        input: Ingredient,
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            name: name,
            input: [input],
            output: [output],
            machines: [Legacy.Buildings.nuclearPowerPlant.id],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension Legacy.Recipes {
    // Nuclear Power Plant
    static let uraniumWasteRecipe = Recipe.Static.Legacy(
        id: "uranium-waste",
        name: "Uranium Waste",
        input: .init(Legacy.Parts.uraniumFuelRod, amount: 1),
        output: .init(Legacy.Parts.uraniumWaste, amount: 50),
        duration: 300
    )

    static let plutoniumWasteRecipe = Recipe.Static.Legacy(
        id: "plutonium-waste",
        name: "Plutonium Waste",
        input: .init(Legacy.Parts.plutoniumFuelRod, amount: 1),
        output: .init(Legacy.Parts.plutoniumWaste, amount: 10),
        duration: 600
    )

    static let nuclearPowerPlantRecipes = [
        uraniumWasteRecipe,
        plutoniumWasteRecipe
    ]
}
