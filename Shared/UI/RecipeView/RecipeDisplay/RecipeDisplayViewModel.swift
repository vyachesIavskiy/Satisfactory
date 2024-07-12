import Observation
import SHModels
import SHSettings

@Observable
final class RecipeDisplayViewModel {
//    enum Mode {
//        case display(Recipe)
//        case production(
//            recipe: SingleItemProduction.Output.Recipe,
//            selectedByproduct: (Recipe.Ingredient.Role, any Item)?,
//            canSelectByproduct: (Recipe.Ingredient.Role, any Item) -> Bool,
//            canSelectInput: (any Item) -> Bool,
//            onSelectRecipe: (any Item) -> Void,
//            onSelectByproduct: (Recipe.Ingredient.Role, any Item) -> Void
//        )
//    }
    
//    let mode: Mode
    let recipe: Recipe
    private(set) var viewMode: ViewMode
    
//    var recipeID: String {
//        switch mode {
//        case let .display(recipe): recipe.id
//        case let .production(recipe, _, _, _, _, _): recipe.model.id
//        }
//    }
    
    @ObservationIgnored
    @Dependency(\.settingsService)
    var settingsService
    
    init(recipe: Recipe) {
        @Dependency(\.settingsService.currentSettings)
        var settings
        
        self.recipe = recipe
        self.viewMode = settings().viewMode
    }
    
//    convenience init(
//        recipe: SingleItemProduction.Output.Recipe,
//        selectedByproduct: (Recipe.Ingredient.Role, any Item)?,
//        canSelectByproduct: @escaping (Recipe.Ingredient.Role, any Item) -> Bool,
//        canSelectInput: @escaping (any Item) -> Bool,
//        onSelectRecipe: @escaping (any Item) -> Void,
//        onSelectByproduct: @escaping (Recipe.Ingredient.Role, any Item) -> Void
//    ) {
//        self.init(
//            mode: .production(
//                recipe: recipe,
//                selectedByproduct: selectedByproduct,
//                canSelectByproduct: canSelectByproduct,
//                canSelectInput: canSelectInput,
//                onSelectRecipe: onSelectRecipe,
//                onSelectByproduct: onSelectByproduct
//            )
//        )
//    }
    
//    private init(mode: Mode) {
//        @Dependency(\.settingsService.currentSettings)
//        var settings
//
//        self.mode = mode
//        self.recipe = switch mode {
//        case let .display(recipe): recipe
//        case let .production(recipe, _, _, _, _, _): recipe.model
//        }
//        self.viewMode = settings().viewMode
//    }
    
    @MainActor
    func observeViewMode() async {
        @Dependency(\.settingsService.settings)
        var settings
        
        for await viewMode in settingsService.settings().map(\.viewMode) {
            guard !Task.isCancelled else { break }
            
            if self.viewMode != viewMode {
                self.viewMode = viewMode
            }
        }
    }
    
    @MainActor
    func outputIngredientViewModel() -> RecipeIngredientViewModel {
        RecipeIngredientViewModel(
            displayIngredient: recipe.output,
            amount: recipe.amountPerMinute(for: recipe.output)
        )
    }
    
    @MainActor
    func byproductIngredientViewModels() -> [RecipeIngredientViewModel] {
        recipe.byproducts.map {
            RecipeIngredientViewModel(
                displayIngredient: $0,
                amount: recipe.amountPerMinute(for: $0)
            )
        }
    }
    
    @MainActor
    func inputIngredientViewModels() -> [RecipeIngredientViewModel] {
        recipe.input.map {
            RecipeIngredientViewModel(
                displayIngredient: $0,
                amount: recipe.amountPerMinute(for: $0)
            )
        }
    }
    
//    @MainActor
//    func canSelectByproduct(for item: any Item, role: Recipe.Ingredient.Role) -> Bool {
//        switch mode {
//        case .display:
//            false
//
//        case let .production(_, _, canSelectByproduct, _, _, _):
//            canSelectByproduct(role, item)
//        }
//    }
    
//    @MainActor
//    func canSelectInput(for item: any Item) -> Bool {
//        switch mode {
//        case .display:
//            false
//
//        case let .production(_, _, _, canSelectInput, _, _):
//            canSelectInput(item)
//        }
//    }
    
//    @MainActor
//    func onSelectRecipe(for item: any Item) {
//        switch mode {
//        case .display:
//            break
//
//        case let .production(_, _, _, _, onSelectRecipe, _):
//            onSelectRecipe(item)
//        }
//    }
    
//    @MainActor
//    func onSelectByproduct(item: any Item, role: Recipe.Ingredient.Role) {
//        switch mode {
//        case .display:
//            break
//
//        case let .production(_, _, _, _, _, onSelectByproduct):
//            onSelectByproduct(role, item)
//        }
//    }
    
//    @MainActor
//    func disabled(item: any Item, role: Recipe.Ingredient.Role) -> Bool {
//        switch mode {
//        case .display:
//            false
//
//        case let .production(_, selectedByproduct, _, _, _, _):
//            if let selectedByproduct {
//                if selectedByproduct.1.id == item.id {
//                    selectedByproduct.0 == role
//                } else {
//                    true
//                }
//            } else {
//                false
//            }
//        }
//    }
}
