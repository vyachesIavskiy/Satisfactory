import Observation
import SHModels
import SHSettings
import SingleItemCalculator

@Observable
final class SingleItemProductionRecipeDisplayViewModel {
    let recipe: SingleItemCalculator.OutputRecipe
    
    init(recipe: SingleItemCalculator.OutputRecipe) {
        self.recipe = recipe
    }

    @MainActor
    func outputIngredientViewModel() -> RecipeIngredientViewModel {
        RecipeIngredientViewModel(productionOutput: recipe.output)
    }
    
    @MainActor
    func byproductIngredientViewModels() -> [RecipeIngredientViewModel] {
        recipe.byproducts.map {
            RecipeIngredientViewModel(productionByproduct: $0)
        }
    }
    
    @MainActor
    func inputIngredientViewModels() -> [RecipeIngredientViewModel] {
        recipe.inputs.map {
            RecipeIngredientViewModel(productionInput: $0)
        }
    }
}
