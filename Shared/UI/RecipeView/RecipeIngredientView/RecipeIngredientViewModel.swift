import Observation
import SHModels

@Observable
final class RecipeIngredientViewModel: Identifiable {
    enum Mode {
        case display(ingredient: Recipe.Ingredient, amount: Double)
        case production(ProductionRole)
    }
    
    enum ProductionRole {
        case output(SingleItemProduction.Output.Recipe.OutputIngredient)
        case byproduct(SingleItemProduction.Output.Recipe.OutputIngredient)
        case input(SingleItemProduction.Output.Recipe.InputIngredient)
    }
    
    private let mode: Mode
    
    var id: String {
        switch mode {
        case let  .display(ingredient, _): ingredient.id
            
        case let .production(role):
            switch role {
            case let .output(ingredient), let .byproduct(ingredient): ingredient.id.uuidString
            case let .input(ingredient): ingredient.id.uuidString
            }
        }
    }
    
    var item: any Item {
        switch mode {
        case let .display(ingredient, _): ingredient.item
        case let .production(role):
            switch role {
            case let .output(ingredient): ingredient.item
            case let .byproduct(ingredient): ingredient.item
            case let .input(ingredient): ingredient.item
            }
        }
    }
    
    convenience init(displayIngredient ingredient: Recipe.Ingredient, amount: Double) {
        self.init(mode: .display(ingredient: ingredient, amount: amount))
    }
    
    convenience init(productionOutput ingredient: SingleItemProduction.Output.Recipe.OutputIngredient) {
        self.init(mode: .production(.output(ingredient)))
    }
    
    convenience init(productionByproduct ingredient: SingleItemProduction.Output.Recipe.OutputIngredient) {
        self.init(mode: .production(.byproduct(ingredient)))
    }
    
    convenience init(productionInput ingredient: SingleItemProduction.Output.Recipe.InputIngredient) {
        self.init(mode: .production(.input(ingredient)))
    }

    private init(mode: Mode) {
        self.mode = mode
    }
    
    @MainActor
    func amountViewModels() -> [RecipeIngredientAmountViewModel] {
        func showMainAmount(for ingredient: SingleItemProduction.Output.Recipe.OutputIngredient) -> Bool {
            ingredient.isSelected ||
            ingredient.byproducts.isEmpty ||
            ingredient.byproducts.first?.amount != ingredient.amount
        }
        
        func showMainAmount(for ingredient: SingleItemProduction.Output.Recipe.InputIngredient) -> Bool {
            ingredient.isSelected ||
            ingredient.byproducts.isEmpty ||
            ingredient.byproducts.first?.amount != ingredient.amount
        }
        
        var result = [RecipeIngredientAmountViewModel]()
        
        switch mode {
        case let .display(ingredient, amount):
            result.append(RecipeIngredientAmountViewModel(recipeIngredient: ingredient, amount: amount))
            
        case let .production(role):
            switch role {
            case let .output(ingredient):
                result.append(RecipeIngredientAmountViewModel(productionOutput: ingredient))
                result += ingredient.byproducts.map {
                    RecipeIngredientAmountViewModel(productionSecondaryByproduct: $0, item: ingredient.item)
                }
                
            case let .byproduct(ingredient):
                if showMainAmount(for: ingredient) {
                    result.append(RecipeIngredientAmountViewModel(productionByproduct: ingredient))
                }
                result += ingredient.byproducts.map {
                    RecipeIngredientAmountViewModel(productionSecondaryByproduct: $0, item: ingredient.item)
                }
                
            case let .input(ingredient):
                if showMainAmount(for: ingredient) {
                    result.append(RecipeIngredientAmountViewModel(productionInput: ingredient))
                }
                result += ingredient.byproducts.map {
                    RecipeIngredientAmountViewModel(productionSecondaryByproduct: $0, item: ingredient.item)
                }
            }
        }
        
        return result
    }
}
