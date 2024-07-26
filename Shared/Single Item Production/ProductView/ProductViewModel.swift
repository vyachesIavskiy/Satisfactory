import Foundation
import Observation
import SHStorage
import SHModels
import SHSingleItemProduction

@Observable
final class ProductViewModel: Identifiable {
    let product: SHSingleItemProduction.OutputItem
    let selectedByproduct: ProductionViewModel.ByproductSelection?
    let canPerformAction: (SingleProductionAction) -> Bool
    let performAction: (SingleProductionAction) -> Void
    
    var id: UUID {
        product.id
    }
    
    var canAdjust: Bool {
        canPerformAction(.adjust(product))
    }
    
    var hasOnlyOneRecipe: Bool {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.recipes(for: product.item, as: [.output, .byproduct]).count == 1
    }
    
    init(
        product: SHSingleItemProduction.OutputItem,
        selectedByproduct: ProductionViewModel.ByproductSelection?,
        canPerformAction: @escaping (SingleProductionAction) -> Bool,
        performAction: @escaping (SingleProductionAction) -> Void
    ) {
        self.product = product
        self.canPerformAction = canPerformAction
        self.performAction = performAction
        self.selectedByproduct = selectedByproduct
    }
    
    @MainActor
    func outputRecipeViewModel(for recipe: SHSingleItemProduction.OutputRecipe) -> SingleItemProductionRecipeSelectViewModel {
        SingleItemProductionRecipeSelectViewModel(
            product: product,
            recipe: recipe,
            selectedByproduct: selectedByproduct,
            canPerformAction: canPerformAction,
            performAction: performAction
        )
    }
    
    @MainActor
    func adjust() {
        performAction(.adjust(product))
    }
    
    @MainActor
    func removeItem() {
        performAction(.removeItem(product.item))
    }
}
