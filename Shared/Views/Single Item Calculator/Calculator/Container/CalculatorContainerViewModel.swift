import Observation
import SHModels
import SHStorage
import SHSettings

@Observable
final class SingleItemCalculatorContainerViewModel {
    enum State: Hashable {
        case initialRecipeSelection(viewModel: SingleItemCalculatorInitialRecipeSelectionViewModel)
        case calculation(viewModel: SingleItemCalculatorViewModel)
    }
    
    var state: State
    
    @MainActor
    init(part: Part) {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService)
        var settingsService
        
        let recipes = storageService.recipes(for: part, as: [.output, .byproduct])
        let pinnedRecipes = storageService.pinnedRecipeIDs(for: part, as: [.output, .byproduct])
        
        if
            settingsService.autoSelectSingleRecipe,
            recipes.count == 1,
            let recipe = recipes.first,
            !recipe.id.contains("packaged")
        {
            SingleItemCalculatorViewModel.AutoSelectSingleRecipeTip.shouldDisplay = true
            state = .calculation(viewModel: SingleItemCalculatorViewModel(part: part, recipe: recipe))
        } else if
            settingsService.autoSelectSinglePinnedRecipe,
            pinnedRecipes.count == 1,
            let recipe = pinnedRecipes.first.flatMap(storageService.recipe(id:))
        {
            SingleItemCalculatorViewModel.AutoSelectSinglePinnedRecipeTip.shouldDisplay = true
            state = .calculation(viewModel: SingleItemCalculatorViewModel(part: part, recipe: recipe))
        } else {
            let initialRecipeSelectionViewModel = SingleItemCalculatorInitialRecipeSelectionViewModel(part: part)
            state = .initialRecipeSelection(viewModel: initialRecipeSelectionViewModel)
            initialRecipeSelectionViewModel.onRecipeSelected = { [weak self] recipe in
                guard let self else { return }
                
                state = .calculation(viewModel: SingleItemCalculatorViewModel(part: part, recipe: recipe))
            }
        }
    }
    
    @MainActor
    init(production: SingleItemProduction) {
        state = .calculation(viewModel: SingleItemCalculatorViewModel(production: production))
    }
}
