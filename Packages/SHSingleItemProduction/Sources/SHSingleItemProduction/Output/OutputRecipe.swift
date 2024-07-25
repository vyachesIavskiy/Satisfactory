import Foundation
import SHModels

extension SHSingleItemProduction {
    public struct OutputRecipe: Identifiable, Equatable {
        public let id = UUID()
        public let recipe: SHModels.Recipe
        public var output: OutputIngredient
        public var byproducts: [OutputIngredient]
        public var inputs: [InputIngredient]
        public var proportion: SHProductionProportion
        
        public init(
            recipe: SHModels.Recipe,
            output: OutputIngredient,
            byproducts: [OutputIngredient],
            inputs: [InputIngredient],
            proportion: SHProductionProportion
        ) {
            self.recipe = recipe
            self.output = output
            self.byproducts = byproducts
            self.inputs = inputs
            self.proportion = proportion
        }
    }
}

extension Sequence<SHSingleItemProduction.OutputRecipe> {
    func first(recipe: Recipe) -> Element? {
        first { $0.recipe.id == recipe.id }
    }
    
    func contains(recipe: Recipe) -> Bool {
        contains { $0.recipe.id == recipe.id }
    }
}

extension Collection<SHSingleItemProduction.OutputRecipe> {
    func firstIndex(recipe: Recipe) -> Index? {
        firstIndex { $0.recipe.id == recipe.id }
    }
}

extension SHSingleItemProduction.OutputRecipe {
    public struct OutputIngredient: Identifiable {
        public let id = UUID()
        public let item: any Item
        public var amount: Double
        public var byproducts: [Byproduct]
        public var isSelected: Bool
        
        public init(item: any Item, amount: Double, byproducts: [Byproduct], isSelected: Bool) {
            self.item = item
            self.amount = amount
            self.byproducts = byproducts
            self.isSelected = isSelected
        }
    }
    
    public struct InputIngredient: Identifiable {
        public let id = UUID()
        public var producingProductID: UUID?
        public let item: any Item
        public var amount: Double
        public var byproducts: [Byproduct]
        public var isSelected: Bool
        
        public init(producingProductID: UUID? = nil, item: any Item, amount: Double, byproducts: [Byproduct], isSelected: Bool) {
            self.producingProductID = producingProductID
            self.item = item
            self.amount = amount
            self.byproducts = byproducts
            self.isSelected = isSelected
        }
    }
    
    public struct Byproduct: Equatable {
        public let index: Int
        public var amount: Double
        
        public init(index: Int, amount: Double) {
            self.index = index
            self.amount = amount
        }
    }
}

extension SHSingleItemProduction.OutputRecipe.OutputIngredient: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.item.id == rhs.item.id &&
        lhs.amount == rhs.amount &&
        lhs.byproducts == rhs.byproducts &&
        lhs.isSelected == rhs.isSelected
    }
}

extension SHSingleItemProduction.OutputRecipe.InputIngredient: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.producingProductID == rhs.producingProductID &&
        lhs.item.id == rhs.item.id &&
        lhs.amount == rhs.amount &&
        lhs.byproducts == rhs.byproducts &&
        lhs.isSelected == rhs.isSelected
    }
}