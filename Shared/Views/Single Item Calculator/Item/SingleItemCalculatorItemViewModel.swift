import Foundation
import Observation
import SHStorage
import SHModels
import SHSingleItemCalculator

struct SingleItemCalculatorItemViewModel: Identifiable {
    let part: SingleItemCalculator.OutputPart
    let byproductSelectionState: SingleItemCalculatorViewModel.ByproductSelectionState?
    let canPerformAction: (SingleItemCalculatorViewModel.Action) -> Bool
    let performAction: (SingleItemCalculatorViewModel.Action) -> Void
    
    var id: UUID {
        part.id
    }
    
    var canAdjust: Bool {
        canPerformAction(.adjust(part))
    }
    
    var hasOnlyOneRecipe: Bool {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.recipes(for: part.part, as: [.output, .byproduct]).count == 1
    }
    
    init(part: SingleItemCalculator.OutputPart) {
        self.init(
            part: part,
            byproductSelectionState: nil,
            canPerformAction: { _ in false },
            performAction: { _ in }
        )
    }
    
    init(
        part: SingleItemCalculator.OutputPart,
        byproductSelectionState: SingleItemCalculatorViewModel.ByproductSelectionState?,
        canPerformAction: @escaping (SingleItemCalculatorViewModel.Action) -> Bool,
        performAction: @escaping (SingleItemCalculatorViewModel.Action) -> Void
    ) {
        self.part = part
        self.byproductSelectionState = byproductSelectionState
        self.canPerformAction = canPerformAction
        self.performAction = performAction
    }
    
    @MainActor
    func outputRecipeViewModel(for recipe: SingleItemCalculator.OutputRecipe) -> CalculatorRecipeViewModel {
        CalculatorRecipeViewModel(
            outputRecipe: recipe,
            byproductSelectionState: byproductSelectionState,
            canPerformAction: canPerformAction,
            performAction: performAction
        )
    }
    
    @MainActor
    func adjust() {
        performAction(.adjust(part))
    }
    
    @MainActor
    func removeItem() {
        performAction(.removePart(part.part))
    }
}
