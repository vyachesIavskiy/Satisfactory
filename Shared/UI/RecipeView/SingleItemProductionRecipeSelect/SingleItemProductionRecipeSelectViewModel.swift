import Observation
import SHModels
import SHSettings
import SHSingleItemProduction

@Observable
final class SingleItemProductionRecipeSelectViewModel {
    private let product: SHSingleItemProduction.OutputItem
    let recipe: SHSingleItemProduction.OutputRecipe
    private let selectedByproduct: ProductionViewModel.ByproductSelection?
    private let canPerformAction: (SingleProductionAction) -> Bool
    private let performAction: (SingleProductionAction) -> Void
    
    init(
        product: SHSingleItemProduction.OutputItem,
        recipe: SHSingleItemProduction.OutputRecipe,
        selectedByproduct: ProductionViewModel.ByproductSelection?,
        canPerformAction: @escaping (SingleProductionAction) -> Bool,
        performAction: @escaping (SingleProductionAction) -> Void
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
    func canSelectByproductProducer(for ingredient: SHSingleItemProduction.OutputRecipe.OutputIngredient) -> Bool {
        canPerformAction(.selectByproductProducer(product: product, ingredient: ingredient, recipe: recipe.recipe))
    }
    
    @MainActor
    func selectByproductProducer(for ingredient: SHSingleItemProduction.OutputRecipe.OutputIngredient) {
        performAction(.selectByproductProducer(product: product, ingredient: ingredient, recipe: recipe.recipe))
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
    func canConfirmByproduct(_ ingredient: SHSingleItemProduction.OutputRecipe.OutputIngredient) -> Bool {
        canSelectByproductProducer(for: ingredient) && selectedByproduct?.consumingRecipe != nil
    }
    
    @MainActor
    func canConfirmByproduct(_ ingredient: SHSingleItemProduction.OutputRecipe.InputIngredient) -> Bool {
        canSelectByproductConsumer(for: ingredient) && selectedByproduct?.producingRecipe != nil
    }
}
