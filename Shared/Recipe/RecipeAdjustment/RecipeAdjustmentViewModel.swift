import Observation
import SHModels
import SingleItemCalculator

@Observable
final class RecipeAdjustmentViewModel {
    let recipe: SingleItemCalculator.OutputRecipe
    let numberOfRecipes: Int
    let allowAdjustment: Bool
    let allowDeletion: Bool
    let onChange: (Proportion) -> Void
    let onDelete: () -> Void
    
    @MainActor
    init(
        recipe: SingleItemCalculator.OutputRecipe,
        numberOfRecipes: Int,
        allowAdjustment: Bool,
        allowDeletion: Bool,
        onChange: @escaping (Proportion) -> Void,
        onDelete: @escaping () -> Void
    ) {
        self.recipe = recipe
        self.numberOfRecipes = numberOfRecipes
        self.allowAdjustment = allowAdjustment
        self.allowDeletion = allowDeletion
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    @MainActor
    func proportionViewModel() -> ProductionProportionViewModel {
        ProductionProportionViewModel(
            proportion: recipe.proportion,
            totalAmount: recipe.output.amount,
            numberOfRecipes: numberOfRecipes,
            onChange: onChange
        )
    }
}