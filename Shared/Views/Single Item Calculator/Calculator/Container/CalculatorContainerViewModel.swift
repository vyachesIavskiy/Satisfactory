import Observation
import SHModels
import SHStorage

@Observable
final class SingleItemCalculatorContainerViewModel {
    enum State: Hashable {
        case initialRecipeSelection(viewModel: SingleItemCalculatorInitialRecipeSelectionViewModel)
        case calculation(viewModel: SingleItemCalculatorViewModel)
    }
    
    var state: State
    
    @MainActor
    init(item: some Item) {
        @Dependency(\.storageService)
        var storageService
        
        let recipes = storageService.recipes(for: item, as: [.output, .byproduct])
        let pinnedRecipes = storageService.pinnedRecipeIDs(for: item, as: [.output, .byproduct])
        
        if
            recipes.count == 1,
            let recipe = recipes.first,
            !recipe.id.contains("packaged")
        {
            state = .calculation(viewModel: SingleItemCalculatorViewModel(item: item, recipe: recipe))
        } else if pinnedRecipes.count == 1, let recipe = pinnedRecipes.first.flatMap(storageService.recipe(id:)) {
            state = .calculation(viewModel: SingleItemCalculatorViewModel(item: item, recipe: recipe))
        } else {
            let initialRecipeSelectionViewModel = SingleItemCalculatorInitialRecipeSelectionViewModel(item: item)
            state = .initialRecipeSelection(viewModel: initialRecipeSelectionViewModel)
            initialRecipeSelectionViewModel.onRecipeSelected = { [weak self] recipe in
                guard let self else { return }
                
                state = .calculation(viewModel: SingleItemCalculatorViewModel(item: item, recipe: recipe))
            }
        }
    }
    
    @MainActor
    init(production: SingleItemProduction) {
        state = .calculation(viewModel: SingleItemCalculatorViewModel(production: production))
    }
}

extension SingleItemCalculatorContainerViewModel: Hashable {
    static func == (lhs: SingleItemCalculatorContainerViewModel, rhs: SingleItemCalculatorContainerViewModel) -> Bool {
        lhs.state == rhs.state
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(state)
    }
}
