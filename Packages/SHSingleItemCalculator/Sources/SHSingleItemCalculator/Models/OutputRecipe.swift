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
    public struct OutputIngredient: Identifiable, Hashable, CustomStringConvertible {
        public let id: UUID
        public let part: Part
        public var amount: Double
        public var additionalAmounts = [Double]()
        
        public var description: String {
            "id: \(id), \(part), amount: \(amount), additional amounts: \(additionalAmounts)"
        }
        
        public init(id: UUID = UUID(), part: Part, amount: Double, additionalAmounts: [Double] = []) {
            self.id = id
            self.part = part
            self.amount = amount
            self.additionalAmounts = additionalAmounts
        }
    }
    
    public struct ByproductIngredient: Identifiable, Hashable, CustomStringConvertible {
        public let id: UUID
        public let part: Part
        public var amount: Double
        public var byproducts: [Byproduct]
        public var isSelected: Bool
        
        public var description: String {
            "id: \(id), \(part), amount: \(amount), byproducts: \(byproducts), \(isSelected ? "selected" : "not selected")"
        }
        
        public init(id: UUID = UUID(), part: Part, amount: Double, byproducts: [Byproduct], isSelected: Bool) {
            self.id = id
            self.part = part
            self.amount = amount
            self.byproducts = byproducts
            self.isSelected = isSelected
        }
    }
    
    public struct InputIngredient: Identifiable, Hashable, CustomStringConvertible {
        public let id: UUID
        public var producingProductID: UUID?
        public let part: Part
        public var amount: Double
        public var byproducts: [Byproduct]
        public var isSelected: Bool
        
        public var description: String {
            "id: \(id) \(part), amount: \(amount), byproducts: \(byproducts), \(isSelected ? "selected" : "not selected")"
        }
        
        public init(
            id: UUID = UUID(),
            producingProductID: UUID? = nil,
            part: Part,
            amount: Double,
            byproducts: [Byproduct],
            isSelected: Bool
        ) {
            self.id = id
            self.producingProductID = producingProductID
            self.part = part
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
