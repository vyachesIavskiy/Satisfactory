import StaticModels
import Models

extension Models.Recipe {
    init(
        _ recipe: StaticModels.Recipe,
        itemProvider: (_ itemID: String) throws -> Item,
        buildingProvider: (_ buildingID: String) throws -> Models.Building
    ) throws {
        try self.init(
            id: recipe.id,
            input: recipe.inputs.map { try Ingredient($0, itemProvider: itemProvider) },
            output: Ingredient(recipe.output, itemProvider: itemProvider),
            byproducts: recipe.byproducts?.map { try Ingredient($0, itemProvider: itemProvider) } ?? [],
            machines: recipe.machineIDs.map(buildingProvider),
            duration: recipe.duration,
            isDefault: recipe.isDefault
        )
    }
}

private extension Models.Recipe.Ingredient {
    init(_ ingredient: StaticModels.Recipe.Ingredient, itemProvider: (_ itemID: String) throws -> Item) rethrows {
        try self.init(
            item: itemProvider(ingredient.itemID),
            amount: ingredient.amount
        )
    }
}
