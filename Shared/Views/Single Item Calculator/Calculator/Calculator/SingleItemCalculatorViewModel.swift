import SwiftUI
import TipKit
import SHModels
import SHSettings
import SHSingleItemCalculator

@Observable
final class SingleItemCalculatorViewModel {
    // MARK: Observed
    var outputItemViewModels = [SingleItemCalculatorItemViewModel]()
    var modalNavigationState: ModalNavigationState?
    var showingUnsavedConfirmationDialog = false
    var canBeDismissedWithoutSaving = true
    var dismissAfterProductionDeletion = false
    
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
    private var settings: SHSettings.Settings
    
    @ObservationIgnored
    private var explicitlyDeletedItemIDs = Set<String>()
    
    @ObservationIgnored
    private var calculator: SingleItemCalculator
    
    let autoSelectSingleRecipeTip: AutoSelectSingleRecipeTip
    let autoSelectSinglePinnedRecipeTip: AutoSelectSinglePinnedRecipeTip
    
    private let shouldDismissIfDeleted: Bool
    
    @ObservationIgnored
    var amount: Double {
        didSet {
            canBeDismissedWithoutSaving = false
        }
    }
    
    var item: any Item {
        calculator.item
    }
    
    @MainActor
    var selectingByproduct: Bool {
        byproductSelectionState != nil
    }
    
    var hasSavedProduction: Bool {
        calculator.hasSavedProduction
    }
    
    var navigationTitle: String {
        if hasSavedProduction {
            calculator.production.name
        } else {
            item.localizedName
        }
    }
    
    var saveProductionTitle: LocalizedStringKey {
        if hasSavedProduction {
            "general-edit"
        } else {
            "general-save"
        }
    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    // MARK: Init
    convenience init(item: some Item, recipe: Recipe) {
        let calculator = SingleItemCalculator(item: item)
        self.init(calculator: calculator, shouldDismissIfDeleted: false)
        
        addInitialRecipe(recipe)
    }
    
    convenience init(production: SingleItemProduction) {
        let calculator = SingleItemCalculator(production: production)
        self.init(calculator: calculator, shouldDismissIfDeleted: true)
                
        update()
    }
    
    private init(calculator: SingleItemCalculator, shouldDismissIfDeleted: Bool) {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService)
        var settingsService
        
        self.calculator = calculator
        amount = calculator.amount
        pins = storageService.pins()
        settings = settingsService.settings
        autoSelectSingleRecipeTip = AutoSelectSingleRecipeTip(item: calculator.item)
        autoSelectSinglePinnedRecipeTip = AutoSelectSinglePinnedRecipeTip(item: calculator.item)
        self.shouldDismissIfDeleted = shouldDismissIfDeleted
    }
    
    // MARK: -
    
    func addRecipe(_ recipe: Recipe, to item: some Item) {
        calculator.addRecipe(recipe, to: item)
        addInputRecipesIfNeeded()
        update()
        
        canBeDismissedWithoutSaving = false
    }
    
    func moveItems(indexSet: IndexSet, at position: Int) {
//        production.moveInputItems(from: indexSet, to: position)
    }
    
    func adjustNewAmount() {
        amount = max(amount, 0.1)
    }
    
    func editProduction(onSave: (() -> Void)? = nil) {
        let mode = if hasSavedProduction {
            EditProductionViewModel.Mode.edit
        } else {
            EditProductionViewModel.Mode.new
        }
        let production = Production.singleItem(calculator.production)
        
        let viewModel = EditProductionViewModel(mode, production: production) { [weak self] savedProduction in
            guard let self else { return }
            
            calculator.save()
            calculator.production.name = savedProduction.name
            canBeDismissedWithoutSaving = true
            onSave?()
        } onDelete: { [weak self] in
            guard let self else { return }
            
            if shouldDismissIfDeleted {
                dismissAfterProductionDeletion = true
            } else {
                calculator.deleteSavedProduction()
            }
        }
        
        modalNavigationState = .editProduction(viewModel: viewModel)
    }
    
    @MainActor
    func cancelByproductSelection() {
        byproductSelectionState = nil
    }
    
    // MARK: Update
    func update() {
        calculator.amount = amount
        calculator.update()
        
        Task { @MainActor [weak self] in
            self?.buildOutputItemViewModels()
        }
    }
    
    func showStatistics() {
        var productionToShow = calculator.production
        if !hasSavedProduction {
            productionToShow.name = item.localizedName
        }
        modalNavigationState = .statistics(viewModel: StatisticsViewModel(production: .singleItem(productionToShow)))
    }
}

// MARK: Hashable
extension SingleItemCalculatorViewModel: Hashable {
    static func == (lhs: SingleItemCalculatorViewModel, rhs: SingleItemCalculatorViewModel) -> Bool {
        lhs.calculator.production == rhs.calculator.production
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(calculator.production)
    }
}

// MARK: Private
private extension SingleItemCalculatorViewModel {
    func addInitialRecipe(_ recipe: Recipe) {
        calculator.amount = recipe.amountPerMinute(for: recipe.output)
        amount = calculator.amount
        calculator.addRecipe(recipe, to: item)
        addInputRecipesIfNeeded()
        update()
        
        // Update this value since it was reset
        canBeDismissedWithoutSaving = true
    }
    
    // MARK: Auto-selection recipes
    func addInputRecipesIfNeeded() {
        let addSingleRecipe = settings.autoSelectSingleRecipe
        let addPinnedRecipe = settings.autoSelectSinglePinnedRecipe
        
        guard addSingleRecipe || addSingleRecipe else { return }
        
        for inputItem in calculator.production.inputItems {
            for recipe in inputItem.recipes {
                let inputItems = recipe.recipe.inputs.map(\.item)
                
                for inputItem in inputItems {
                    guard
                        !calculator.production.inputItems.contains(item: inputItem),
                        !explicitlyDeletedItemIDs.contains(inputItem.id)
                    else { continue }
                    
                    let isNaturalResource = (inputItem as? Part)?.isNaturalResource == true
                    
                    if addSingleRecipe, !isNaturalResource {
                        let recipes = storageService.recipes(for: inputItem, as: [.output, .byproduct])
                        if
                            recipes.count == 1,
                            let recipe = recipes.first,
                            !recipe.id.contains("packaged")
                        {
                            calculator.addRecipe(recipe, to: inputItem)
                        }
                    }
                    
                    if addPinnedRecipe, !isNaturalResource {
                        let pinnedRecipeIDs = storageService.pinnedRecipeIDs(for: inputItem, as: [.output, .byproduct])
                        if
                            pinnedRecipeIDs.count == 1,
                            let recipe = pinnedRecipeIDs.first.flatMap(storageService.recipe(id:)),
                            !recipe.id.contains("packaged")
                        {
                            calculator.addRecipe(recipe, to: inputItem)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Can perform actions
    @MainActor
    func canAdjustItem(_ outputItem: SingleItemCalculator.OutputItem) -> Bool {
        byproductSelectionState == nil &&
        (outputItem.item.id != item.id ||
        storageService.recipes(for: outputItem.item, as: [.output, .byproduct]).count > 1)
    }
    
    func canRemoveItem(_ item: some Item) -> Bool {
        item.id != self.item.id
    }
    
    @MainActor
    func canSelectRecipe(for input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        byproductSelectionState == nil &&
        !calculator.production.inputItems.contains(item: input.item) &&
        !storageService.recipes(for: input.item, as: [.output, .byproduct]).isEmpty
    }
    
    @MainActor
    func canSelectByproductProducer(byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) -> Bool {
        // If producing recipe is not yet selected
        byproductSelectionState?.producingRecipe == nil &&
        
        // If production has at least one input with the same item
        calculator.outputRecipesContains {
            !calculator.hasConsumer(byproduct.item, recipe: $0.recipe) &&
            $0.inputs.contains { $0.item.id == byproduct.item.id }
        }
    }
    
    @MainActor
    func canUnselectByproductProducer(
        byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient,
        recipe: Recipe
    ) -> Bool {
        calculator.hasProducer(byproduct.item, recipe: recipe)
    }
    
    @MainActor
    func canSelectByproductConsumer(input: SingleItemCalculator.OutputRecipe.InputIngredient) -> Bool {
        // If consuming recipe is not yet selected
        byproductSelectionState?.consumingRecipe == nil &&
        
        calculator.outputRecipesContains {
            !calculator.hasProducer(input.item, recipe: $0.recipe) &&
            $0.byproducts.contains { $0.item.id == input.item.id }
        }
    }
    
    @MainActor
    func canUnselectByproductConsumer(
        input: SingleItemCalculator.OutputRecipe.InputIngredient,
        recipe: Recipe
    ) -> Bool {
        calculator.hasConsumer(input.item, recipe: recipe)
    }
    
    // MARK: Perform actions
    func adjustItem(_ outputItem: SingleItemCalculator.OutputItem) {
        autoSelectSingleRecipeTip.invalidate(reason: .actionPerformed)
        autoSelectSinglePinnedRecipeTip.invalidate(reason: .actionPerformed)
        modalNavigationState = .adjustItem(
            viewModel: SingleItemCalculatorItemAdjustmentViewModel(
                item: outputItem,
                excludeRecipesForItems: calculator.production.inputItems.map(\.item),
                allowDeletion: outputItem.item.id != item.id
            ) { [weak self] outputItem in
                guard let self else { return }
                
                if outputItem.recipes.isEmpty {
                    calculator.removeInputItem(outputItem.item)
                    explicitlyDeletedItemIDs.insert(outputItem.item.id)
                } else {
                    calculator.updateInputItem(outputItem)
                }
                
                modalNavigationState = nil
                update()
            }
        )
    }
    
    func removeItem(_ item: some Item) {
        autoSelectSingleRecipeTip.invalidate(reason: .actionPerformed)
        autoSelectSinglePinnedRecipeTip.invalidate(reason: .actionPerformed)
        calculator.removeInputItem(item)
        explicitlyDeletedItemIDs.insert(item.id)
        update()
        
        canBeDismissedWithoutSaving = false
    }
    
    @MainActor
    func selectRecipe(for ingredient: SingleItemCalculator.OutputRecipe.InputIngredient) {
        autoSelectSingleRecipeTip.invalidate(reason: .actionPerformed)
        autoSelectSinglePinnedRecipeTip.invalidate(reason: .actionPerformed)
        let viewModel = SingleItemCalculatorInitialRecipeSelectionViewModel(
            item: ingredient.item,
            excludeRecipesForItems: calculator.production.inputItems.map(\.item)
        ) { [weak self] recipe in
            guard let self else { return }
            
            modalNavigationState = nil
            addRecipe(recipe, to: ingredient.item)
            update()
        }
        
        modalNavigationState = .selectInitialRecipeForItem(viewModel: viewModel)
    }
    
    @MainActor
    func selectByproductProducer(byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient, recipe: Recipe) {
        if byproductSelectionState == nil {
            byproductSelectionState = ByproductSelectionState(
                item: byproduct.item,
                producingRecipe: recipe
            )
        } else {
            byproductSelectionState?.producingRecipe = recipe
        }
        
        checkByproductSelectionState()
    }
    
    @MainActor
    func unselectByproductProducer(byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient, recipe: Recipe) {
        calculator.removeProducer(recipe, for: byproduct.item)
        
        update()
    }
    
    @MainActor
    func selectByproductConsumer(input: SingleItemCalculator.OutputRecipe.InputIngredient, recipe: Recipe) {
        if byproductSelectionState == nil {
            byproductSelectionState = ByproductSelectionState(
                item: input.item,
                consumingRecipe: recipe
            )
        } else {
            byproductSelectionState?.consumingRecipe = recipe
        }
        
        checkByproductSelectionState()
    }
    
    @MainActor
    func unselectByproductConsumer(input: SingleItemCalculator.OutputRecipe.InputIngredient, recipe: Recipe) {
        calculator.removeConsumer(recipe, for: input.item)
        
        update()
    }
    
    @MainActor
    func checkByproductSelectionState() {
        guard
            let item = byproductSelectionState?.item,
            let producingRecipe = byproductSelectionState?.producingRecipe,
            let consumingRecipe = byproductSelectionState?.consumingRecipe
        else { return }
        
        byproductSelectionState = nil
        
        calculator.addByproduct(item, producer: producingRecipe, consumer: consumingRecipe)
        update()
        
        canBeDismissedWithoutSaving = false
    }
    
    // MARK: ViewModels
    @MainActor
    func buildOutputItemViewModels() {
        outputItemViewModels = calculator.outputItems.map { outputItem in
            SingleItemCalculatorItemViewModel(
                item: outputItem,
                byproductSelectionState: byproductSelectionState,
                canPerformAction: { [weak self] action in
                    guard let self else { return false }
                    
                    return switch action {
                    case let .adjust(item):
                        canAdjustItem(item)
                        
                    case let .removeItem(item):
                        canRemoveItem(item)
                        
                    case let .selectRecipeForInput(input):
                        canSelectRecipe(for: input)
                        
                    case let .selectByproductProducer(byproduct, _):
                        canSelectByproductProducer(byproduct: byproduct)
                        
                    case let .unselectByproductProducer(byproduct, recipe):
                        canUnselectByproductProducer(byproduct: byproduct, recipe: recipe)
                        
                    case let .selectByproductConsumer(input, _):
                        canSelectByproductConsumer(input: input)
                        
                    case let .unselectByproductConsumer(input, recipe):
                        canUnselectByproductConsumer(input: input, recipe: recipe)
                    }
                },
                performAction: { [weak self] action in
                    guard let self else { return }
                    
                    switch action {
                    case let .adjust(product):
                        adjustItem(product)
                        
                    case let .removeItem(item):
                        removeItem(item)
                        
                    case let .selectRecipeForInput(input):
                        selectRecipe(for: input)
                        
                    case let .selectByproductProducer(byproduct, recipe):
                        selectByproductProducer(byproduct: byproduct, recipe: recipe)
                        
                    case let .unselectByproductProducer(byproduct, recipe):
                        unselectByproductProducer(byproduct: byproduct, recipe: recipe)
                        
                    case let .selectByproductConsumer(input, recipe):
                        selectByproductConsumer(input: input, recipe: recipe)
                        
                    case let .unselectByproductConsumer(input, recipe):
                        unselectByproductConsumer(input: input, recipe: recipe)
                    }
                }
            )
        }
    }
}

// MARK: Action
extension SingleItemCalculatorViewModel {
    enum Action {
        case adjust(SingleItemCalculator.OutputItem)
        case removeItem(any Item)
        case selectRecipeForInput(SingleItemCalculator.OutputRecipe.InputIngredient)
        case selectByproductProducer(
            byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient,
            recipe: Recipe
        )
        case unselectByproductProducer(
            byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient,
            recipe: Recipe
        )
        case selectByproductConsumer(
            input: SingleItemCalculator.OutputRecipe.InputIngredient,
            recipe: Recipe
        )
        case unselectByproductConsumer(
            input: SingleItemCalculator.OutputRecipe.InputIngredient,
            recipe: Recipe
        )
    }
}

// MARK: ModalNavigationState
extension SingleItemCalculatorViewModel {
    enum ModalNavigationState: Identifiable {
        case selectInitialRecipeForItem(viewModel: SingleItemCalculatorInitialRecipeSelectionViewModel)
        case adjustItem(viewModel: SingleItemCalculatorItemAdjustmentViewModel)
        case editProduction(viewModel: EditProductionViewModel)
        case statistics(viewModel: StatisticsViewModel)
        
        var id: String {
            switch self {
            case let .selectInitialRecipeForItem(viewModel): viewModel.item.id
            case let .adjustItem(viewModel): viewModel.id.uuidString
            case let .editProduction(viewModel): viewModel.id.uuidString
            case let .statistics(viewModel): viewModel.id
            }
        }
    }
}

// MARK: ByproductSelectionState
extension SingleItemCalculatorViewModel {
    struct ByproductSelectionState {
        let item: any Item
        var producingRecipe: Recipe?
        var consumingRecipe: Recipe?
    }
}

// MARK: Tips
extension SingleItemCalculatorViewModel {
    struct AutoSelectSingleRecipeTip: Tip {
        @Parameter
        static var shouldDisplay: Bool = false
        
        let item: any Item
        
        var title: Text {
            Text("single-item-production-tip-auto-select-single-recipe-title")
        }
        
        var message: Text? {
            Text("single-item-production-tip-auto-select-single-recipe-message-\(item.localizedName)")
        }
        
        var rules: [Rule] {
            #Rule(Self.$shouldDisplay) {
                $0 == true
            }
        }
        
        var options: [any TipOption] {
            Tips.MaxDisplayCount(1)
        }
    }
    
    struct AutoSelectSinglePinnedRecipeTip: Tip {
        @Parameter
        static var shouldDisplay: Bool = false
        
        let item: any Item
        
        var title: Text {
            Text("single-item-production-tip-auto-select-single-pinned-recipe-title")
        }
        
        var message: Text? {
            Text("single-item-production-tip-auto-select-single-pinned-recipe-message-\(item.localizedName)")
        }
        
        var rules: [Rule] {
            #Rule(Self.$shouldDisplay) {
                $0 == true
            }
        }
        
        var options: [any TipOption] {
            Tips.MaxDisplayCount(1)
        }
    }
}
