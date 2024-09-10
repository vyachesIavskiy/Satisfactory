import Foundation
import Observation
import SHStorage
import SHModels
import SHSingleItemCalculator

public struct SingleItemCalculatorItemViewModel: Identifiable {
    let item: SingleItemCalculator.OutputItem
    let byproductSelectionState: SingleItemCalculatorViewModel.ByproductSelectionState?
    let canPerformAction: (SingleItemCalculatorViewModel.Action) -> Bool
    let performAction: (SingleItemCalculatorViewModel.Action) -> Void
    
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
    
    init(item: SingleItemCalculator.OutputItem) {
        self.init(
            item: item,
            byproductSelectionState: nil,
            canPerformAction: { _ in false },
            performAction: { _ in }
        )
    }
    
    init(
        item: SingleItemCalculator.OutputItem,
        byproductSelectionState: SingleItemCalculatorViewModel.ByproductSelectionState?,
        canPerformAction: @escaping (SingleItemCalculatorViewModel.Action) -> Bool,
        performAction: @escaping (SingleItemCalculatorViewModel.Action) -> Void
    ) {
        self.item = item
        self.byproductSelectionState = byproductSelectionState
        self.canPerformAction = canPerformAction
        self.performAction = performAction
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
