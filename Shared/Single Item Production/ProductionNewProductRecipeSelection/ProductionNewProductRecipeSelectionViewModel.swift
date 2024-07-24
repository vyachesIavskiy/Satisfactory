import Observation
import SHModels

@Observable
final class ProductionNewProductRecipeSelectionViewModel {
    let item: any Item
    let selectedRecipeIDs: [String]
    let onSelectRecipe: @MainActor (Recipe) -> Void
    
    init(
        item: any Item,
        selectedRecipeIDs: [String],
        onSelectRecipe: @MainActor @escaping (Recipe) -> Void
    ) {
        self.item = item
        self.selectedRecipeIDs = selectedRecipeIDs
        self.onSelectRecipe = onSelectRecipe
    }
    
    @MainActor
    var itemRecipesViewModel: SingleItemProductionInitialRecipeSelectionViewModel {
        SingleItemProductionInitialRecipeSelectionViewModel(
            item: item,
            filterOutRecipeIDs: selectedRecipeIDs,
            onRecipeSelected: onSelectRecipe
        )
    }
}
