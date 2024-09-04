import Observation
import SHModels

@Observable
public final class RecipeIngredientViewModel: Identifiable {
    private let state: RecipeIngredientViewModelState
        
    public var id: String {
        state.id
    }
    
    var item: any Item {
        state.item
    }
    
    var amountViewModels: [RecipeIngredientAmountViewModel] {
        state.amountViewModels
    }
    
    public convenience init(ingredient: Recipe.Ingredient, amount: Double) {
        self.init(state: RecipeState(ingredient: ingredient, amount: amount))
    }

    public init(state: RecipeIngredientViewModelState) {
        self.state = state
    }
}
