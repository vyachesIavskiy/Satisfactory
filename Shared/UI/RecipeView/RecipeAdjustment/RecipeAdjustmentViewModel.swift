import Observation
import SHModels
import SHSingleItemProduction

@Observable
final class RecipeAdjustmentViewModel {
    let recipe: SHSingleItemProduction.OutputRecipe
    let numberOfRecipes: Int
    let allowAdjustment: Bool
    let allowDeletion: Bool
    let onChange: (SHProductionProportion) -> Void
    let onDelete: () -> Void
    
    @MainActor
    init(
        recipe: SHSingleItemProduction.OutputRecipe,
        numberOfRecipes: Int,
        allowAdjustment: Bool,
        allowDeletion: Bool,
        onChange: @escaping (SHProductionProportion) -> Void,
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
