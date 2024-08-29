import Observation
import SHModels
import SingleItemCalculator

@Observable
final class RecipeAdjustmentViewModel {
    let recipe: SingleItemCalculator.OutputRecipe
    let itemAmount: Double
    let allowAdjustment: Bool
    let allowDeletion: Bool
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
        onChange: @escaping (Proportion) -> Void,
        onDelete: @escaping () -> Void
    ) {
        self.recipe = recipe
        self.itemAmount = itemAmount
        self.allowAdjustment = allowAdjustment
        self.allowDeletion = allowDeletion
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    @MainActor
    func proportionViewModel() -> ProductionProportionViewModel {
        ProductionProportionViewModel(
            proportion: recipe.proportion,
            recipeAmount: recipe.output.amount,
            itemAmount: itemAmount,
            onChange: onChange
        )
    }
}
