import SHModels

public protocol RecipeIngredientViewModelState {
    var id: String { get }
    var item: any Item { get }
    var amountViewModels: [RecipeIngredientAmountViewModel] { get }
}

extension RecipeIngredientViewModel {
    struct RecipeState: RecipeIngredientViewModelState {
        private let ingredient: Recipe.Ingredient
        private let amount: Double
        
        var id: String { ingredient.id }
        var item: any Item { ingredient.item }
        var amountViewModels: [RecipeIngredientAmountViewModel] {
            [RecipeIngredientAmountViewModel(recipeIngredient: ingredient, amount: amount)]
        }
        
        init(ingredient: Recipe.Ingredient, amount: Double) {
            self.ingredient = ingredient
            self.amount = amount
        }
    }
}
