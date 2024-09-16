import SHSharedUI
import SHModels
import SHSingleItemCalculator

struct RecipeIngredientSingleItemViewModelState: RecipeIngredientViewModelState {
    private let ingredient: Ingredient
    
    var id: String {
        switch ingredient {
        case let .output(ingredient): ingredient.id.uuidString
        case let .byproduct(ingredient): ingredient.id.uuidString
        case let .input(ingredient): ingredient.id.uuidString
        }
    }
    
    var part: Part {
        switch ingredient {
        case let .output(ingredient): ingredient.part
        case let .byproduct(ingredient): ingredient.part
        case let .input(ingredient): ingredient.part
        }
    }
    
    var amountViewModels: [RecipeIngredientAmountViewModel] {
        var result = [RecipeIngredientAmountViewModel]()
        
        switch ingredient {
        case let .output(ingredient):
            result.append(RecipeIngredientAmountViewModel(productionOutput: ingredient))
            for additionalAmount in ingredient.additionalAmounts {
                result.append(
                    RecipeIngredientAmountViewModel(additionalProductionOutput: ingredient, amount: additionalAmount)
                )
            }
            
        case let .byproduct(ingredient):
            let showMainAmount = if !ingredient.byproducts.isEmpty {
                ingredient.amount > 0 &&
                ingredient.byproducts.first?.amount != ingredient.amount
            } else {
                true
            }
            
            if showMainAmount {
                result.append(RecipeIngredientAmountViewModel(productionByproduct: ingredient))
            }
            
            result += ingredient.byproducts.map {
                RecipeIngredientAmountViewModel(productionSecondaryByproduct: $0, part: ingredient.part)
            }
            
        case let .input(ingredient):
            if ingredient.amount > 0 {
                result.append(RecipeIngredientAmountViewModel(productionInput: ingredient))
            }
            
            result += ingredient.byproducts.map {
                RecipeIngredientAmountViewModel(productionSecondaryByproduct: $0, part: ingredient.part)
            }
        }
        
        return result
    }
    
    init(_ output: SingleItemCalculator.OutputRecipe.OutputIngredient) {
        self.init(ingredient: .output(output))
    }
    
    init(_ byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) {
        self.init(ingredient: .byproduct(byproduct))
    }
    
    init(_ input: SingleItemCalculator.OutputRecipe.InputIngredient) {
        self.init(ingredient: .input(input))
    }
    
    private init(ingredient: Ingredient) {
        self.ingredient = ingredient
    }
}

extension RecipeIngredientSingleItemViewModelState {
    enum Ingredient {
        case output(SingleItemCalculator.OutputRecipe.OutputIngredient)
        case byproduct(SingleItemCalculator.OutputRecipe.ByproductIngredient)
        case input(SingleItemCalculator.OutputRecipe.InputIngredient)
    }
}

#if DEBUG
import SwiftUI
import SHStorage

#Preview("Output") {
    @Dependency(\.storageService)
    var storageService
    
    let output = SingleItemCalculator.OutputRecipe.OutputIngredient(
        part: storageService.part(id: "part-iron-plate")!,
        amount: 10
    )
    
    RecipeIngredientView(viewModel: RecipeIngredientViewModel(
        state: RecipeIngredientSingleItemViewModelState(output)
    ))
}

#Preview("Byproduct") {
    @Dependency(\.storageService)
    var storageService
    
    let byproduct = SingleItemCalculator.OutputRecipe.ByproductIngredient(
        part: storageService.part(id: "part-iron-plate")!,
        amount: 10,
        byproducts: [],
        isSelected: false
    )
    
    RecipeIngredientView(viewModel: RecipeIngredientViewModel(
        state: RecipeIngredientSingleItemViewModelState(byproduct)
    ))
}

#Preview("Byproduct (additional amount)") {
    @Dependency(\.storageService)
    var storageService
    
    let byproduct = SingleItemCalculator.OutputRecipe.ByproductIngredient(
        part: storageService.part(id: "part-iron-plate")!,
        amount: 0,
        byproducts: [SingleItemCalculator.OutputRecipe.Byproduct(index: 0, amount: 10)],
        isSelected: false
    )
    
    RecipeIngredientView(viewModel: RecipeIngredientViewModel(
        state: RecipeIngredientSingleItemViewModelState(byproduct)
    ))
}

#Preview("Input") {
    @Dependency(\.storageService)
    var storageService
    
    let input = SingleItemCalculator.OutputRecipe.InputIngredient(
        part: storageService.part(id: "part-iron-plate")!,
        amount: 10,
        byproducts: [],
        isSelected: false
    )
    
    RecipeIngredientView(viewModel: RecipeIngredientViewModel(
        state: RecipeIngredientSingleItemViewModelState(input)
    ))
}

#Preview("Input (additional amount)") {
    @Dependency(\.storageService)
    var storageService
    
    let input = SingleItemCalculator.OutputRecipe.InputIngredient(
        part: storageService.part(id: "part-iron-plate")!,
        amount: 0,
        byproducts: [SingleItemCalculator.OutputRecipe.Byproduct(index: 0, amount: 10)],
        isSelected: false
    )
    
    RecipeIngredientView(viewModel: RecipeIngredientViewModel(
        state: RecipeIngredientSingleItemViewModelState(input)
    ))
}
#endif
