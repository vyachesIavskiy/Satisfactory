import Observation
import SHSingleItemProduction

@Observable
final class RecipeAdjustmentViewModel {
    let recipe: SingleItemProduction.Output.Recipe
    let allowAdjustment: Bool
    let allowDeletion: Bool
    let onChange: (SHProductionProportion) -> Void
    let onDelete: () -> Void
    
    var proportion: SHProductionProportion {
        didSet {
            onChange(proportion)
        }
    }
    
    @MainActor
    init(
        recipe: SingleItemProduction.Output.Recipe,
        allowAdjustment: Bool,
        allowDeletion: Bool,
        onChange: @escaping (SHProductionProportion) -> Void,
        onDelete: @escaping () -> Void
    ) {
        self.recipe = recipe
        self.allowAdjustment = allowAdjustment
        self.allowDeletion = allowDeletion
        self.onChange = onChange
        self.onDelete = onDelete
        self.proportion = recipe.proportion
    }
}
