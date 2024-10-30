import Observation
import SHSharedUI
import SHModels
import SHSettings
import SHSingleItemCalculator

@MainActor
struct CalculatorRecipeViewModel {
    let outputRecipe: SingleItemCalculator.OutputRecipe
    let byproductSelectionState: SingleItemCalculatorViewModel.ByproductSelectionState?
    private let canPerformAction: (SingleItemCalculatorViewModel.Action) -> Bool
    private let performAction: (SingleItemCalculatorViewModel.Action) -> Void
    
    var outputViewModel: RecipeIngredientViewModel {
        RecipeIngredientViewModel(outputRecipe.output)
    }
    
    var byproductViewModels: [RecipeIngredientViewModel] {
        outputRecipe.byproducts.map(RecipeIngredientViewModel.init)
    }
    
    var inputViewModels: [RecipeIngredientViewModel] {
        outputRecipe.inputs.map(RecipeIngredientViewModel.init)
    }
    
    init(
        outputRecipe: SingleItemCalculator.OutputRecipe,
        byproductSelectionState: SingleItemCalculatorViewModel.ByproductSelectionState?,
        canPerformAction: @escaping (SingleItemCalculatorViewModel.Action) -> Bool,
        performAction: @escaping (SingleItemCalculatorViewModel.Action) -> Void
    ) {
        self.outputRecipe = outputRecipe
        self.byproductSelectionState = byproductSelectionState
        self.canPerformAction = canPerformAction
        self.performAction = performAction
    }

    // Recipe
    func canSelectRecipe(for input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        canPerformAction(.selectRecipeForInput(input))
    }
    
    func selectRecipe(for input: SingleItemCalculator.OutputRecipe.InputIngredient) {
        performAction(.selectRecipeForInput(input))
    }
    
    // Select byproduct producer
    func canSelectByproductProducer(for byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) -> Bool {
        canPerformAction(.selectByproductProducer(byproduct: byproduct, recipe: outputRecipe.recipe))
    }
    
    func selectByproductProducer(for byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) {
        performAction(.selectByproductProducer(byproduct: byproduct, recipe: outputRecipe.recipe))
    }
    
    // Unselect byproduct producer
    func canUnselectByproductProducer(for byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) -> Bool {
        canPerformAction(.unselectByproductProducer(byproduct: byproduct, recipe: outputRecipe.recipe))
    }
    
    func unselectByproductProducer(for byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) {
        performAction(.unselectByproductProducer(byproduct: byproduct, recipe: outputRecipe.recipe))
    }
    
    // Select byproduct consumer
    func canSelectByproductConsumer(for input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        canPerformAction(.selectByproductConsumer(input: input, recipe: outputRecipe.recipe))
    }
    
    func selectByproductConsumer(for input: SingleItemCalculator.OutputRecipe.InputIngredient) {
        performAction(.selectByproductConsumer(input: input, recipe: outputRecipe.recipe))
    }
    
    // Unselect byproduct consumer
    func canUnselectByproductConsumer(for input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        canPerformAction(.unselectByproductConsumer(input: input, recipe: outputRecipe.recipe))
    }
    
    func unselectByproductConsumer(for input: SingleItemCalculator.OutputRecipe.InputIngredient) {
        performAction(.unselectByproductConsumer(input: input, recipe: outputRecipe.recipe))
    }
    
    // Can confirm byproduct
    func canConfirmByproduct(_ byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) -> Bool {
        canSelectByproductProducer(for: byproduct) && byproductSelectionState?.consumingRecipe != nil
    }
    
    func canConfirmByproduct(_ input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        canSelectByproductConsumer(for: input) && byproductSelectionState?.producingRecipe != nil
    }
}
