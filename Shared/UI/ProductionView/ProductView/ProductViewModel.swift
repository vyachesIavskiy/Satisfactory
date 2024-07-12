import Foundation
import Observation
import SHModels

@Observable
final class ProductViewModel: Identifiable {
    let product: SingleItemProduction.Output.Product
    let selectedByproduct: ProductionViewModel.ByproductSelection2?
    let canPerformAction: (SingleProductionAction) -> Bool
    let performAction: (SingleProductionAction) -> Void
    
    var id: UUID {
        product.id
    }
    
    var canAdjust: Bool {
        canPerformAction(.adjust(product))
    }
    
    init(
        product: SingleItemProduction.Output.Product,
        selectedByproduct: ProductionViewModel.ByproductSelection2?,
        canPerformAction: @escaping (SingleProductionAction) -> Bool,
        performAction: @escaping (SingleProductionAction) -> Void
    ) {
        self.product = product
        self.canPerformAction = canPerformAction
        self.performAction = performAction
        self.selectedByproduct = selectedByproduct
    }
    
    @MainActor
    func viewModel(for recipe: SingleItemProduction.Output.Recipe) -> SingleItemProductionRecipeSelectViewModel {
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
}
