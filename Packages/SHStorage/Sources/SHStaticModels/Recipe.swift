import Foundation
import SHModels

extension Recipe {
    public struct Static: Codable {
        public let id: String
        public let output: Ingredient
        public let byproducts: [Ingredient]?
        public let inputs: [Ingredient]
        public let machineID: String?
        public let manualCraftingIDs: [String]
        public let duration: Int
        public let isDefault: Bool
        
        public init(
            id: String,
            output: Ingredient,
            byproducts: [Ingredient]?,
            inputs: [Ingredient],
            machineID: String?,
            manualCraftingIDs: [String],
            duration: Int,
            isDefault: Bool
        ) {
            self.id = id
            self.output = output
            self.byproducts = byproducts
            self.inputs = inputs
            self.machineID = machineID
            self.manualCraftingIDs = manualCraftingIDs
            self.duration = duration
            self.isDefault = isDefault
        }
    }
    
    public init(
        _ recipe: Recipe.Static,
        itemProvider: (_ itemID: String) throws -> any Item,
        buildingProvider: (_ buildingID: String) throws -> Building
    ) throws {
        try self.init(
            id: recipe.id,
            output: Ingredient(.output, ingredient: recipe.output, itemProvider: itemProvider),
            byproducts: recipe.byproducts?.map { try Ingredient(.byproduct, ingredient: $0, itemProvider: itemProvider) } ?? [],
            inputs: recipe.inputs.map { try Ingredient(.input, ingredient: $0, itemProvider: itemProvider) },
            machine: recipe.machineID.map(buildingProvider),
            manualCrafting: recipe.manualCraftingIDs.map(buildingProvider),
            duration: recipe.duration,
            isDefault: recipe.isDefault
        )
    }
}

extension Recipe.Static {
    public struct Ingredient: Codable {
        public let itemID: String
        public let amount: Double
        
        public init(itemID: String, amount: Double) {
            self.itemID = itemID
            self.amount = amount
        }
    }
}

private extension Recipe.Ingredient {
    init(
        _ role: Recipe.Ingredient.Role,
        ingredient: Recipe.Static.Ingredient,
        itemProvider: (_ itemID: String) throws -> any Item
    ) rethrows {
        try self.init(
            role: role,
            item: itemProvider(ingredient.itemID),
            amount: ingredient.amount
        )
    }
}
