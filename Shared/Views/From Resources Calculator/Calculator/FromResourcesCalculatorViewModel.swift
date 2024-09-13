import Observation
import SHModels
import SHStorage
import SHSettings
import SHFromResourcesCalculator

@Observable
final class FromResourcesCalculatorViewModel {
    // MARK: Observed
//    var outputItemViewModels = [FromResourcesCalculatorItemViewModel]()
    var modalNavigationState: ModalNavigationState?
    var showingUnsavedConfirmationDialog = false
    var canBeDismissedWithoutSaving = true
    
    @MainActor
    private var byproductSelectionState: ByproductSelectionState? {
        didSet {
            buildOutputItemViewModels()
        }
    }
    
    // MARK: Ignored
    @ObservationIgnored
    private var pins: Pins
    
    @ObservationIgnored
    private var settings: Settings
    
    @ObservationIgnored
    private var explicitlyDeletedItemIDs = Set<String>()
    
    @ObservationIgnored
    private var calculator: FromResourcesCalculator
    
//    var hasUnsavedChanges: Bool {
//        calculator.hasUnsavedChanges
//    }
    
    @MainActor
    var selectingByproduct: Bool {
        byproductSelectionState != nil
    }
    
//    var hasSavedProduction: Bool {
//        calculator.hasSavedProduction
//    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    convenience init(part: Part, recipe: Recipe) {
        let calculator = FromResourcesCalculator(/*item: item*/)
        self.init(calculator: calculator)
        
//        addInitialRecipe(recipe)
    }
    
    convenience init(production: SingleItemProduction) {
        let calculator = FromResourcesCalculator(/*production: production*/)
        self.init(calculator: calculator)
                
//        update()
    }
    
    private init(calculator: FromResourcesCalculator) {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService)
        var settingsService
        
        self.calculator = calculator
        pins = storageService.pins()
        settings = settingsService.settings
    }
    
    // MARK: Update
    func update() {
//        calculator.update()
        
        Task { @MainActor [weak self] in
            self?.buildOutputItemViewModels()
        }
    }
    
    func showStatistics() {
//        modalNavigationState = .statistics(viewModel: StatisticsViewModel(production: .singleItem(calculator.production)))
    }
}

// MARK: Hashable
extension FromResourcesCalculatorViewModel: Hashable {
    static func == (lhs: FromResourcesCalculatorViewModel, rhs: FromResourcesCalculatorViewModel) -> Bool {
//        lhs.calculator.production == rhs.calculator.production
        true
    }
    
    func hash(into hasher: inout Hasher) {
//        hasher.combine(calculator.production)
    }
}

private extension FromResourcesCalculatorViewModel {
    // MARK: ViewModels
    @MainActor
    func buildOutputItemViewModels() {
//        outputItemViewModels = calculator.outputItems.map { outputItem in
//            SingleItemCalculatorItemViewModel(
//                item: outputItem,
//                byproductSelectionState: byproductSelectionState,
//                canPerformAction: { [weak self] action in
//                    guard let self else { return false }
//                    
//                    return switch action {
//                    case let .adjust(item):
//                        canAdjustItem(item)
//                        
//                    case let .removeItem(item):
//                        canRemoveItem(item)
//                        
//                    case let .selectRecipeForInput(input):
//                        canSelectRecipe(for: input)
//                        
//                    case let .selectByproductProducer(byproduct, _):
//                        canSelectByproductProducer(byproduct: byproduct)
//                        
//                    case let .unselectByproductProducer(byproduct, recipe):
//                        canUnselectByproductProducer(byproduct: byproduct, recipe: recipe)
//                        
//                    case let .selectByproductConsumer(input, _):
//                        canSelectByproductConsumer(input: input)
//                        
//                    case let .unselectByproductConsumer(input, recipe):
//                        canUnselectByproductConsumer(input: input, recipe: recipe)
//                    }
//                },
//                performAction: { [weak self] action in
//                    guard let self else { return }
//                    
//                    switch action {
//                    case let .adjust(product):
//                        adjustItem(product)
//                        
//                    case let .removeItem(item):
//                        removeItem(item)
//                        
//                    case let .selectRecipeForInput(input):
//                        selectRecipe(for: input)
//                        
//                    case let .selectByproductProducer(byproduct, recipe):
//                        selectByproductProducer(byproduct: byproduct, recipe: recipe)
//                        
//                    case let .unselectByproductProducer(byproduct, recipe):
//                        unselectByproductProducer(byproduct: byproduct, recipe: recipe)
//                        
//                    case let .selectByproductConsumer(input, recipe):
//                        selectByproductConsumer(input: input, recipe: recipe)
//                        
//                    case let .unselectByproductConsumer(input, recipe):
//                        unselectByproductConsumer(input: input, recipe: recipe)
//                    }
//                }
//            )
//        }
    }
}

// MARK: Action
extension FromResourcesCalculatorViewModel {
//    enum Action {
//        case adjust(FromResourcesCalculator.OutputItem)
//        case removeItem(any Item)
//        case selectRecipeForInput(FromResourcesCalculator.OutputRecipe.InputIngredient)
//        case selectByproductProducer(
//            byproduct: FromResourcesCalculator.OutputRecipe.ByproductIngredient,
//            recipe: Recipe
//        )
//        case unselectByproductProducer(
//            byproduct: FromResourcesCalculator.OutputRecipe.ByproductIngredient,
//            recipe: Recipe
//        )
//        case selectByproductConsumer(
//            input: FromResourcesCalculator.OutputRecipe.InputIngredient,
//            recipe: Recipe
//        )
//        case unselectByproductConsumer(
//            input: FromResourcesCalculator.OutputRecipe.InputIngredient,
//            recipe: Recipe
//        )
//    }
}

// MARK: ModalNavigationState
extension FromResourcesCalculatorViewModel {
    enum ModalNavigationState: Identifiable {
        case selectInitialRecipeForItem(viewModel: SingleItemCalculatorInitialRecipeSelectionViewModel)
        case adjustItem(viewModel: SingleItemCalculatorItemAdjustmentViewModel)
        case editProduction(viewModel: EditProductionViewModel)
        case statistics(viewModel: StatisticsViewModel)
        
        var id: String {
            switch self {
            case let .selectInitialRecipeForItem(viewModel): viewModel.part.id
            case let .adjustItem(viewModel): viewModel.id.uuidString
            case let .editProduction(viewModel): viewModel.id.uuidString
            case let .statistics(viewModel): viewModel.id
            }
        }
    }
}

// MARK: ByproductSelectionState
extension FromResourcesCalculatorViewModel {
    struct ByproductSelectionState {
        let part: Part
        var producingRecipe: Recipe?
        var consumingRecipe: Recipe?
    }
}
