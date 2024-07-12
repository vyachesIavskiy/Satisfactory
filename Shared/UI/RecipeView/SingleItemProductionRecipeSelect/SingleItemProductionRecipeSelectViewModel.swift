import Observation
import SHModels
import SHSettings

@Observable
final class SingleItemProductionRecipeSelectViewModel {
    private let product: SingleItemProduction.Output.Product
    let recipe: SingleItemProduction.Output.Recipe
    private let selectedByproduct: ProductionViewModel.ByproductSelection2?
    private let canPerformAction: (SingleProductionAction) -> Bool
    private let performAction: (SingleProductionAction) -> Void
    
    init(
        product: SingleItemProduction.Output.Product,
        recipe: SingleItemProduction.Output.Recipe,
        selectedByproduct: ProductionViewModel.ByproductSelection2?,
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
    func canSelectRecipe(for input: SingleItemProduction.Output.Recipe.InputIngredient) -> Bool {
        canPerformAction(.selectRecipeForInput(input))
    }
    
    @MainActor
    func selectRecipe(for input: SingleItemProduction.Output.Recipe.InputIngredient) {
        performAction(.selectRecipeForInput(input))
    }
    
    @MainActor
    func canSelectByproductProducer(for ingredient: SingleItemProduction.Output.Recipe.OutputIngredient) -> Bool {
        canPerformAction(.selectByproductProducer(product: product, ingredient: ingredient, recipe: recipe.model))
    }
    
    @MainActor
    func selectByproductProducer(for ingredient: SingleItemProduction.Output.Recipe.OutputIngredient) {
        performAction(.selectByproductProducer(product: product, ingredient: ingredient, recipe: recipe.model))
    }
    
    @MainActor
    func canSelectByproductConsumer(for input: SingleItemProduction.Output.Recipe.InputIngredient) -> Bool {
        canPerformAction(.selectByproductConsumer(input: input, recipe: recipe.model))
    }
    
    @MainActor
    func selectByproductConsumer(for input: SingleItemProduction.Output.Recipe.InputIngredient) {
        performAction(.selectByproductConsumer(input: input, recipe: recipe.model))
    }
    
    @MainActor
    func ingredientDisabled(_ ingredient: SingleItemProduction.Output.Recipe.OutputIngredient) -> Bool {
        guard let selectedByproduct else { return false }
        
        return selectedByproduct.item.id != ingredient.item.id ||
        recipe.model.id == selectedByproduct.producingRecipe?.id ||
        recipe.model.id == selectedByproduct.consumingRecipe?.id
    }
    
    @MainActor
    func ingredientDisabled(_ ingredient: SingleItemProduction.Output.Recipe.InputIngredient) -> Bool {
        guard let selectedByproduct else { return false }
        
        return selectedByproduct.item.id != ingredient.item.id ||
        recipe.model.id == selectedByproduct.producingRecipe?.id ||
        recipe.model.id == selectedByproduct.consumingRecipe?.id
    }
    
    @MainActor
    func canConfirmByproduct(_ ingredient: SingleItemProduction.Output.Recipe.OutputIngredient) -> Bool {
        canSelectByproductProducer(for: ingredient) && selectedByproduct?.consumingRecipe != nil
    }
    
    @MainActor
    func canConfirmByproduct(_ ingredient: SingleItemProduction.Output.Recipe.InputIngredient) -> Bool {
        canSelectByproductConsumer(for: ingredient) && selectedByproduct?.producingRecipe != nil
    }
}
