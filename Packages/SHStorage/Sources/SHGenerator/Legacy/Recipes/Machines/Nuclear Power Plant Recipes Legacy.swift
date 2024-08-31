import SHModels
import SHStaticModels

private extension Recipe.Static.Legacy {
    init(id: String, output: Ingredient, input: Ingredient) {
        self.init(id: id, output: [output], input: [input])
    }
}

extension Legacy.Recipes {
    // Nuclear Power Plant
    static let uraniumWasteRecipe = Recipe.Static.Legacy(
        id: "uranium-waste",
        output: .init(Legacy.Parts.uraniumWaste),
        input: .init(Legacy.Parts.uraniumFuelRod)
    )

    static let plutoniumWasteRecipe = Recipe.Static.Legacy(
        id: "plutonium-waste",
        output: .init(Legacy.Parts.plutoniumWaste),
        input: .init(Legacy.Parts.plutoniumFuelRod)
    )

    static let nuclearPowerPlantRecipes = [
        uraniumWasteRecipe,
        plutoniumWasteRecipe
    ]
}
