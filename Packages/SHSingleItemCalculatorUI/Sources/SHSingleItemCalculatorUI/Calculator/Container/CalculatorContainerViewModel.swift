import Observation
import SHModels
import SHStorage

@Observable
final class CalculatorContainerViewModel {
    enum State: Hashable {
        case initialRecipeSelection(viewModel: InitialRecipeSelectionViewModel)
        case calculation(viewModel: CalculatorViewModel)
    }
    
    var state: State
    
    @MainActor
    init(item: some Item) {
        @Dependency(\.storageService)
        var storageService
        
        let recipes = storageService.recipes(for: item, as: [.output, .byproduct])
        if
            recipes.count == 1,
            let recipe = recipes.first,
            !recipe.id.contains("packaged")
        {
            state = .calculation(viewModel: CalculatorViewModel(item: item, recipe: recipe))
        } else {
            let initialRecipeSelectionViewModel = InitialRecipeSelectionViewModel(item: item)
            state = .initialRecipeSelection(viewModel: initialRecipeSelectionViewModel)
            initialRecipeSelectionViewModel.onRecipeSelected = { [weak self] recipe in
                guard let self else { return }
                
                state = .calculation(viewModel: CalculatorViewModel(item: item, recipe: recipe))
            }
        }
    }
    
    @MainActor
    init(production: SingleItemProduction) {
        state = .calculation(viewModel: CalculatorViewModel(production: production))
    }
}

extension CalculatorContainerViewModel: Hashable {
    static func == (lhs: CalculatorContainerViewModel, rhs: CalculatorContainerViewModel) -> Bool {
        lhs.state == rhs.state
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(state)
    }
}
