import Foundation
import SHModels

extension SingleItemProduction {
    struct Output {
        var products: [Product]
        var unselectedItems: [any Item]
        var hasByproducts: Bool
    }
}

extension SingleItemProduction.Output: Equatable {
    static func == (lhs: SingleItemProduction.Output, rhs: SingleItemProduction.Output) -> Bool {
        lhs.products == rhs.products &&
        lhs.unselectedItems.map(\.id) == rhs.unselectedItems.map(\.id) &&
        lhs.hasByproducts == rhs.hasByproducts
    }
}

extension SingleItemProduction.Output {
    struct Product: Identifiable {
        let id = UUID()
        let item: any Item
        var recipes: [Recipe]
        
        var amount: Double {
            recipes.reduce(0.0) { $0 + $1.output.amount }
        }
    }
}

extension SingleItemProduction.Output.Product: Equatable {
    static func == (lhs: SingleItemProduction.Output.Product, rhs: SingleItemProduction.Output.Product) -> Bool {
        lhs.item.id == rhs.item.id &&
        lhs.recipes == rhs.recipes
    }
}

extension SingleItemProduction.Output {
    struct Recipe: Identifiable, Equatable {
        let model: SHModels.Recipe
        var output: OutputIngredient
        var byproducts: [OutputIngredient]
        var inputs: [InputIngredient]
        var proportion: ProductionProportion
        
        var id: String { model.id }
    }
}

extension SingleItemProduction.Output.Recipe {
    struct OutputIngredient: Identifiable {
        let id = UUID()
        let item: any Item
        var amount: Double
        var byproducts: [Byproduct]
        var isSelected: Bool
    }
    
    struct InputIngredient: Identifiable {
        let id = UUID()
        var producingProductID: UUID?
        let item: any Item
        var amount: Double
        var byproducts: [Byproduct]
        var isSelected: Bool
    }
    
    struct Byproduct: Equatable {
        let index: Int
        var amount: Double
    }
}

extension SingleItemProduction.Output.Recipe.OutputIngredient: Equatable {
    static func == (lhs: SingleItemProduction.Output.Recipe.OutputIngredient, rhs: SingleItemProduction.Output.Recipe.OutputIngredient) -> Bool {
        lhs.id == rhs.id &&
        lhs.item.id == rhs.item.id &&
        lhs.amount == rhs.amount &&
        lhs.byproducts == rhs.byproducts &&
        lhs.isSelected == rhs.isSelected
    }
}

extension SingleItemProduction.Output.Recipe.InputIngredient: Equatable {
    static func == (lhs: SingleItemProduction.Output.Recipe.InputIngredient, rhs: SingleItemProduction.Output.Recipe.InputIngredient) -> Bool {
        lhs.id == rhs.id &&
        lhs.producingProductID == rhs.producingProductID &&
        lhs.item.id == rhs.item.id &&
        lhs.amount == rhs.amount &&
        lhs.byproducts == rhs.byproducts &&
        lhs.isSelected == rhs.isSelected
    }
}
