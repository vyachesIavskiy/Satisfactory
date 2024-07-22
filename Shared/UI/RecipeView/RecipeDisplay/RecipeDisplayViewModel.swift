import Observation
import SHModels
import SHSettings

@Observable
final class RecipeDisplayViewModel {
    let recipe: Recipe
    let pinned: Bool
    
    @ObservationIgnored
    @Dependency(\.settingsService)
    var settingsService
    
    init(recipe: Recipe, pinned: Bool) {
        self.recipe = recipe
        self.pinned = pinned
    }
        
    @MainActor
    func outputIngredientViewModel() -> RecipeIngredientViewModel {
        RecipeIngredientViewModel(
            displayIngredient: recipe.output,
            amount: recipe.amountPerMinute(for: recipe.output)
        )
    }
    
    @MainActor
    func byproductIngredientViewModels() -> [RecipeIngredientViewModel] {
        recipe.byproducts.map {
            RecipeIngredientViewModel(
                displayIngredient: $0,
                amount: recipe.amountPerMinute(for: $0)
            )
        }
    }
    
    @MainActor
    func inputIngredientViewModels() -> [RecipeIngredientViewModel] {
        recipe.input.map {
            RecipeIngredientViewModel(
                displayIngredient: $0,
                amount: recipe.amountPerMinute(for: $0)
            )
        }
    }
}
