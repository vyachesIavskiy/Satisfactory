import Observation
import SHModels
import SHSettings
import SHSingleItemProduction

@Observable
final class SingleItemProductionRecipeSelectViewModel {
    private let product: SHSingleItemProduction.OutputItem
    let recipe: SHSingleItemProduction.OutputRecipe
    let selectedByproduct: CalculationViewModel.ByproductSelectionState?
    private let canPerformAction: (CalculationViewModel.Action) -> Bool
    private let performAction: (CalculationViewModel.Action) -> Void
    
    init(
        product: SHSingleItemProduction.OutputItem,
        recipe: SHSingleItemProduction.OutputRecipe,
        selectedByproduct: CalculationViewModel.ByproductSelectionState?,
        canPerformAction: @escaping (CalculationViewModel.Action) -> Bool,
        performAction: @escaping (CalculationViewModel.Action) -> Void
    ) {
        self.product = product
        self.recipe = recipe
        self.selectedByproduct = selectedByproduct
        self.canPerformAction = canPerformAction
        self.performAction = performAction
    }

    @MainActor
    func canSelectRecipe(for input: SHSingleItemProduction.OutputRecipe.InputIngredient) -> Bool {
        canPerformAction(.selectRecipeForInput(input))
    }
    
    @MainActor
    func selectRecipe(for input: SHSingleItemProduction.OutputRecipe.InputIngredient) {
        performAction(.selectRecipeForInput(input))
    }
    
    @MainActor
    func canSelectByproductProducer(for ingredient: SHSingleItemProduction.OutputRecipe.ByproductIngredient) -> Bool {
        canPerformAction(.selectByproductProducer(ingredient: ingredient, recipe: recipe.recipe))
    }
    
    @MainActor
    func selectByproductProducer(for ingredient: SHSingleItemProduction.OutputRecipe.ByproductIngredient) {
        performAction(.selectByproductProducer(ingredient: ingredient, recipe: recipe.recipe))
    }
    
    @MainActor
    func canSelectByproductConsumer(for input: SHSingleItemProduction.OutputRecipe.InputIngredient) -> Bool {
        canPerformAction(.selectByproductConsumer(input: input, recipe: recipe.recipe))
    }
    
    @MainActor
    func selectByproductConsumer(for input: SHSingleItemProduction.OutputRecipe.InputIngredient) {
        performAction(.selectByproductConsumer(input: input, recipe: recipe.recipe))
    }
    
    @MainActor
    func ingredientDisabled(_ ingredient: SHSingleItemProduction.OutputRecipe.OutputIngredient) -> Bool {
        guard let selectedByproduct else { return false }
        
        return selectedByproduct.item.id != ingredient.item.id ||
        recipe.recipe.id == selectedByproduct.producingRecipe?.id ||
        recipe.recipe.id == selectedByproduct.consumingRecipe?.id
    }
    
    @MainActor
    func ingredientDisabled(_ ingredient: SHSingleItemProduction.OutputRecipe.InputIngredient) -> Bool {
        guard let selectedByproduct else { return false }
        
        return selectedByproduct.item.id != ingredient.item.id ||
        recipe.recipe.id == selectedByproduct.producingRecipe?.id ||
        recipe.recipe.id == selectedByproduct.consumingRecipe?.id
    }
    
    @MainActor
    func canConfirmByproduct(_ ingredient: SHSingleItemProduction.OutputRecipe.ByproductIngredient) -> Bool {
        canSelectByproductProducer(for: ingredient) && selectedByproduct?.consumingRecipe != nil
    }
    
    @MainActor
    func canConfirmByproduct(_ ingredient: SHSingleItemProduction.OutputRecipe.InputIngredient) -> Bool {
        canSelectByproductConsumer(for: ingredient) && selectedByproduct?.producingRecipe != nil
    }
}
