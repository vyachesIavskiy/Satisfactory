import Foundation
import SHModels

extension SingleItemCalculator {
    public struct OutputRecipe: Identifiable, Hashable, CustomStringConvertible {
        public let id: UUID
        public let recipe: Recipe
        public var output: OutputIngredient
        public var byproducts: [ByproductIngredient]
        public var inputs: [InputIngredient]
        public var proportion: Proportion
        
        public var description: String {
            "\(recipe), output: \(output), byproducts: \(byproducts), inputs: \(inputs)"
        }
        
        public init(
            id: UUID = UUID(),
            recipe: Recipe,
            output: OutputIngredient,
            byproducts: [ByproductIngredient],
            inputs: [InputIngredient],
            proportion: Proportion
        ) {
            self.id = id
            self.recipe = recipe
            self.output = output
            self.byproducts = byproducts
            self.inputs = inputs
            self.proportion = proportion
        }
    }
}

extension Sequence<SingleItemCalculator.OutputRecipe> {
    func first(recipe: Recipe) -> Element? {
        first { $0.recipe.id == recipe.id }
    }
    
    func contains(recipe: Recipe) -> Bool {
        contains { $0.recipe.id == recipe.id }
    }
}

extension Collection<SingleItemCalculator.OutputRecipe> {
    func firstIndex(recipe: Recipe) -> Index? {
        firstIndex { $0.recipe.id == recipe.id }
    }
}

extension SingleItemCalculator.OutputRecipe {
    public struct OutputIngredient: Identifiable, CustomStringConvertible {
        public let id: UUID
        public let item: any Item
        public var amount: Double
        public var additionalAmounts = [Double]()
        
        public var description: String {
            "id: \(id), \(item), amount: \(amount), additional amounts: \(additionalAmounts)"
        }
        
        public init(id: UUID = UUID(), item: any Item, amount: Double) {
            self.id = id
            self.item = item
            self.amount = amount
        }
    }
    
    public struct ByproductIngredient: Identifiable, CustomStringConvertible {
        public let id: UUID
        public let item: any Item
        public var amount: Double
        public var byproducts: [Byproduct]
        public var isSelected: Bool
        
        public var description: String {
            "id: \(id), \(item), amount: \(amount), byproducts: \(byproducts), \(isSelected ? "selected" : "not selected")"
        }
        
        public init(id: UUID = UUID(), item: any Item, amount: Double, byproducts: [Byproduct], isSelected: Bool) {
            self.id = id
            self.item = item
            self.amount = amount
            self.byproducts = byproducts
            self.isSelected = isSelected
        }
    }
    
    public struct InputIngredient: Identifiable, CustomStringConvertible {
        public let id: UUID
        public var producingProductID: UUID?
        public let item: any Item
        public var amount: Double
        public var byproducts: [Byproduct]
        public var isSelected: Bool
        
        public var description: String {
            "id: \(id) \(item), amount: \(amount), byproducts: \(byproducts), \(isSelected ? "selected" : "not selected")"
        }
        
        public init(
            id: UUID = UUID(),
            producingProductID: UUID? = nil,
            item: any Item,
            amount: Double,
            byproducts: [Byproduct],
            isSelected: Bool
        ) {
            self.id = id
            self.producingProductID = producingProductID
            self.item = item
            self.amount = amount
            self.byproducts = byproducts
            self.isSelected = isSelected
        }
    }
    
    public struct Byproduct: Hashable, CustomStringConvertible {
        public let index: Int
        public var amount: Double
        
        public var description: String {
            "index: \(index), amount: \(amount)"
        }
        
        public init(index: Int, amount: Double) {
            self.index = index
            self.amount = amount
        }
    }
}

extension SingleItemCalculator.OutputRecipe.OutputIngredient: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.item.id == rhs.item.id &&
        lhs.amount == rhs.amount
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(item.id)
        hasher.combine(amount)
    }
}

extension SingleItemCalculator.OutputRecipe.ByproductIngredient: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.item.id == rhs.item.id &&
        lhs.amount == rhs.amount &&
        lhs.byproducts == rhs.byproducts &&
        lhs.isSelected == rhs.isSelected
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(item.id)
        hasher.combine(amount)
        hasher.combine(byproducts)
        hasher.combine(isSelected)
    }
}

extension SingleItemCalculator.OutputRecipe.InputIngredient: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.producingProductID == rhs.producingProductID &&
        lhs.item.id == rhs.item.id &&
        lhs.amount == rhs.amount &&
        lhs.byproducts == rhs.byproducts &&
        lhs.isSelected == rhs.isSelected
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(producingProductID)
        hasher.combine(item.id)
        hasher.combine(amount)
        hasher.combine(byproducts)
        hasher.combine(isSelected)
    }
}
