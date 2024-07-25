import Foundation
import SHModels

extension SingleItemProduction {
    public struct Output {
        public var products: [Product]
        public var unselectedItems: [any Item]
        public var hasByproducts: Bool
        
        public init(products: [Product], unselectedItems: [any Item], hasByproducts: Bool) {
            self.products = products
            self.unselectedItems = unselectedItems
            self.hasByproducts = hasByproducts
        }
    }
}

extension SingleItemProduction.Output: Equatable {
    public static func == (lhs: SingleItemProduction.Output, rhs: SingleItemProduction.Output) -> Bool {
        lhs.products == rhs.products &&
        lhs.unselectedItems.map(\.id) == rhs.unselectedItems.map(\.id) &&
        lhs.hasByproducts == rhs.hasByproducts
    }
}

extension SingleItemProduction.Output {
    public struct Product: Identifiable {
        public let id = UUID()
        public let item: any Item
        public var recipes: [Recipe]
        
        public var amount: Double {
            recipes.reduce(0.0) { $0 + $1.output.amount }
        }
        
        public init(item: any Item, recipes: [Recipe]) {
            self.item = item
            self.recipes = recipes
        }
    }
}

extension SingleItemProduction.Output.Product: Equatable {
    public static func == (lhs: SingleItemProduction.Output.Product, rhs: SingleItemProduction.Output.Product) -> Bool {
        lhs.item.id == rhs.item.id &&
        lhs.recipes == rhs.recipes
    }
}

extension SingleItemProduction.Output {
    public struct Recipe: Identifiable, Equatable {
        public let model: SHModels.Recipe
        public var output: OutputIngredient
        public var byproducts: [OutputIngredient]
        public var inputs: [InputIngredient]
        public var proportion: ProductionProportion
        
        public var id: String { model.id }
        
        public init(
            model: SHModels.Recipe,
            output: OutputIngredient,
            byproducts: [OutputIngredient],
            inputs: [InputIngredient],
            proportion: ProductionProportion
        ) {
            self.model = model
            self.output = output
            self.byproducts = byproducts
            self.inputs = inputs
            self.proportion = proportion
        }
    }
}

extension SingleItemProduction.Output.Recipe {
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

extension SingleItemProduction.Output.Recipe.OutputIngredient: Equatable {
    public static func == (lhs: SingleItemProduction.Output.Recipe.OutputIngredient, rhs: SingleItemProduction.Output.Recipe.OutputIngredient) -> Bool {
        lhs.id == rhs.id &&
        lhs.item.id == rhs.item.id &&
        lhs.amount == rhs.amount &&
        lhs.byproducts == rhs.byproducts &&
        lhs.isSelected == rhs.isSelected
    }
}

extension SingleItemProduction.Output.Recipe.InputIngredient: Equatable {
    public static func == (lhs: SingleItemProduction.Output.Recipe.InputIngredient, rhs: SingleItemProduction.Output.Recipe.InputIngredient) -> Bool {
        lhs.id == rhs.id &&
        lhs.producingProductID == rhs.producingProductID &&
        lhs.item.id == rhs.item.id &&
        lhs.amount == rhs.amount &&
        lhs.byproducts == rhs.byproducts &&
        lhs.isSelected == rhs.isSelected
    }
}
