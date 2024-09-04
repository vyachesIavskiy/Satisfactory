import Observation
import SHSharedUI
import SHModels
import SHSettings
import SHSingleItemCalculator

struct CalculatorRecipeViewModel {
    private let product: SingleItemCalculator.OutputItem
    let recipe: SingleItemCalculator.OutputRecipe
    let byproductSelectionState: CalculatorViewModel.ByproductSelectionState?
    private let canPerformAction: (CalculatorViewModel.Action) -> Bool
    private let performAction: (CalculatorViewModel.Action) -> Void
    
    var outputViewModel: RecipeIngredientViewModel {
        RecipeIngredientViewModel(recipe.output)
    }
    
    var byproductViewModels: [RecipeIngredientViewModel] {
        recipe.byproducts.map(RecipeIngredientViewModel.init)
    }
    
    var inputViewModels: [RecipeIngredientViewModel] {
        recipe.inputs.map(RecipeIngredientViewModel.init)
    }
    
    init(
        product: SingleItemCalculator.OutputItem,
        recipe: SingleItemCalculator.OutputRecipe,
        byproductSelectionState: CalculatorViewModel.ByproductSelectionState?,
        canPerformAction: @escaping (CalculatorViewModel.Action) -> Bool,
        performAction: @escaping (CalculatorViewModel.Action) -> Void
    ) {
        self.product = product
        self.recipe = recipe
        self.byproductSelectionState = byproductSelectionState
        self.canPerformAction = canPerformAction
        self.performAction = performAction
    }

    // Recipe
    @MainActor
    func canSelectRecipe(for input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        canPerformAction(.selectRecipeForInput(input))
    }
    
    @MainActor
    func selectRecipe(for input: SingleItemCalculator.OutputRecipe.InputIngredient) {
        performAction(.selectRecipeForInput(input))
    }
    
    // Select byproduct producer
    @MainActor
    func canSelectByproductProducer(for byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) -> Bool {
        canPerformAction(.selectByproductProducer(byproduct: byproduct, recipe: recipe.recipe))
    }
    
    @MainActor
    func selectByproductProducer(for byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) {
        performAction(.selectByproductProducer(byproduct: byproduct, recipe: recipe.recipe))
    }
    
    // Unselect byproduct producer
    @MainActor
    func canUnselectByproductProducer(for byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) -> Bool {
        canPerformAction(.unselectByproductProducer(byproduct: byproduct, recipe: recipe.recipe))
    }
    
    @MainActor
    func unselectByproductProducer(for byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) {
        performAction(.unselectByproductProducer(byproduct: byproduct, recipe: recipe.recipe))
    }
    
    // Select byproduct consumer
    @MainActor
    func canSelectByproductConsumer(for input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        canPerformAction(.selectByproductConsumer(input: input, recipe: recipe.recipe))
    }
    
    @MainActor
    func selectByproductConsumer(for input: SingleItemCalculator.OutputRecipe.InputIngredient) {
        performAction(.selectByproductConsumer(input: input, recipe: recipe.recipe))
    }
    
    // Unselect byproduct consumer
    @MainActor
    func canUnselectByproductConsumer(for input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        canPerformAction(.unselectByproductConsumer(input: input, recipe: recipe.recipe))
    }
    
    @MainActor
    func unselectByproductConsumer(for input: SingleItemCalculator.OutputRecipe.InputIngredient) {
        performAction(.unselectByproductConsumer(input: input, recipe: recipe.recipe))
    }
    
    // Can confirm byproduct
    @MainActor
    func canConfirmByproduct(_ byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) -> Bool {
        canSelectByproductProducer(for: byproduct) && byproductSelectionState?.consumingRecipe != nil
    }
    
    @MainActor
    func canConfirmByproduct(_ input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        canSelectByproductConsumer(for: input) && byproductSelectionState?.producingRecipe != nil
    }
}
