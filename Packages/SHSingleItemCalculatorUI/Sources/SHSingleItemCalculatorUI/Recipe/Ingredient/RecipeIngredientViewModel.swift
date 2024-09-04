import SHSharedUI
import SHSingleItemCalculator

extension RecipeIngredientViewModel {
    convenience init(_ output: SingleItemCalculator.OutputRecipe.OutputIngredient) {
        self.init(state: RecipeIngredientSingleItemViewModelState(output))
    }
    
    convenience init(_ byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) {
        self.init(state: RecipeIngredientSingleItemViewModelState(byproduct))
    }
    
    convenience init(_ input: SingleItemCalculator.OutputRecipe.InputIngredient) {
        self.init(state: RecipeIngredientSingleItemViewModelState(input))
    }
}
