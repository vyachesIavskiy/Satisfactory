import Foundation
import Observation
import SHStorage
import SHModels
import SHSingleItemCalculator

public struct ItemViewModel: Identifiable {
    let item: SingleItemCalculator.OutputItem
    let byproductSelectionState: CalculatorViewModel.ByproductSelectionState?
    let canPerformAction: (CalculatorViewModel.Action) -> Bool
    let performAction: (CalculatorViewModel.Action) -> Void
    
    public var id: UUID {
        item.id
    }
    
    var canAdjust: Bool {
        canPerformAction(.adjust(item))
    }
    
    var hasOnlyOneRecipe: Bool {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.recipes(for: item.item, as: [.output, .byproduct]).count == 1
    }
    
    public init(item: SingleItemCalculator.OutputItem) {
        self.init(item: item, byproductSelectionState: nil, canPerformAction: { _ in false }, performAction: { _ in })
    }
    
    init(
        item: SingleItemCalculator.OutputItem,
        byproductSelectionState: CalculatorViewModel.ByproductSelectionState?,
        canPerformAction: @escaping (CalculatorViewModel.Action) -> Bool,
        performAction: @escaping (CalculatorViewModel.Action) -> Void
    ) {
        self.item = item
        self.canPerformAction = canPerformAction
        self.performAction = performAction
        self.byproductSelectionState = byproductSelectionState
    }
    
    @MainActor
    func outputRecipeViewModel(for recipe: SingleItemCalculator.OutputRecipe) -> CalculatorRecipeViewModel {
        CalculatorRecipeViewModel(
            product: item,
            recipe: recipe,
            byproductSelectionState: byproductSelectionState,
            canPerformAction: canPerformAction,
            performAction: performAction
        )
    }
    
    @MainActor
    func adjust() {
        performAction(.adjust(item))
    }
    
    @MainActor
    func removeItem() {
        performAction(.removeItem(item.item))
    }
}
