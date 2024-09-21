import Observation
import SHModels
import SHSingleItemCalculator

@Observable
final class RecipeAdjustmentViewModel {
    let recipe: SingleItemCalculator.OutputRecipe
    let itemAmount: Double
    let allowAdjustment: Bool
    let allowDeletion: Bool
    let showRecipeProportionTip: Bool
    let onChange: (Proportion) -> Void
    let onDelete: () -> Void
    
    var willBeRemoved: Bool {
        recipe.output.amount.isZero
    }
    
    @MainActor
    init(
        recipe: SingleItemCalculator.OutputRecipe,
        itemAmount: Double,
        allowAdjustment: Bool,
        allowDeletion: Bool,
        showRecipeProportionTip: Bool,
        onChange: @escaping (Proportion) -> Void,
        onDelete: @escaping () -> Void
    ) {
        self.recipe = recipe
        self.itemAmount = itemAmount
        self.allowAdjustment = allowAdjustment
        self.allowDeletion = allowDeletion
        self.showRecipeProportionTip = showRecipeProportionTip
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    @MainActor
    func proportionViewModel() -> ProportionViewModel {
        ProportionViewModel(
            proportion: recipe.proportion,
            recipeAmount: recipe.output.amount,
            itemAmount: itemAmount,
            showTip: showRecipeProportionTip,
            onChange: onChange
        )
    }
}
