import Foundation
import Observation
import SHSingleItemProduction
import SHModels
import SHSettings

@Observable
final class CalculationViewModel {
    // MARK: Ignored properties
    @ObservationIgnored
    private var pins: Pins
    
    @ObservationIgnored
    private var settings: Settings
    
    @ObservationIgnored
    private var explicitlyDeletedItemIDs = Set<String>()
    
    @ObservationIgnored
    private var production: SHSingleItemProduction
    
    @ObservationIgnored
    private var savedProduction: SingleItemProduction?
    
    @ObservationIgnored
    var amount: Double
    
    var item: any Item {
        production.item
    }
    
    var hasUnsavedChanges: Bool {
        // TODO: Implement this
        true
    }
    
    @MainActor
    var selectingByproduct: Bool {
        byproductSelectionState != nil
    }
    
    // MARK: Observed properties
    var outputItemViewModels = [ProductViewModel]()
    var modalNavigationState: ModalNavigationState?
    var showingUnsavedConfirmationDialog = false
    var canBeDismissedWithoutSaving = true
    
    @MainActor
    private var byproductSelectionState: ByproductSelectionState? {
        didSet {
            buildOutputItemViewModels()
        }
    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    convenience init(item: some Item, recipe: Recipe) {
        let production = SHSingleItemProduction(item: item)
        self.init(production: production)
        
        addInitialRecipe(recipe)
    }
    
    convenience init(production: SingleItemProduction) {
        let singleItemProduction = SHSingleItemProduction(production: production)
        self.init(production: singleItemProduction)
        
        self.savedProduction = production
        
        update()
    }
    
    private init(production: SHSingleItemProduction) {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService)
        var settingsService
        
        self.production = production
        amount = production.amount
        pins = storageService.pins()
        settings = settingsService.settings
    }
    
    func addRecipe(_ recipe: Recipe, to item: some Item) {
        production.addRecipe(recipe, to: item)
        addInputRecipesIfNeeded()
        update()
        
        canBeDismissedWithoutSaving = false
    }
    
    func moveItems(indexSet: IndexSet, at position: Int) {
        production.moveInputItems(from: indexSet, to: position)
    }
    
    func saveProduction() {
        // TODO: Show production saving screen
    }
    
    @MainActor
    func cancelByproductSelection() {
        byproductSelectionState = nil
    }
    
    // MARK: Update
    func update() {
        production.amount = amount
        production.update()
        Task { @MainActor [weak self] in
            self?.buildOutputItemViewModels()
        }
    }
}

// MARK: Hashable
extension CalculationViewModel: Hashable {
    static func == (lhs: CalculationViewModel, rhs: CalculationViewModel) -> Bool {
        lhs.production == rhs.production
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(production)
    }
}

// MARK: Private
private extension CalculationViewModel {
    func addInitialRecipe(_ recipe: Recipe) {
        production.amount = recipe.amountPerMinute(for: recipe.output)
        amount = production.amount
        production.addRecipe(recipe, to: item)
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
        
        production.iterateInputItems { inputItemIndex, inputItem in
            production.iterateInputRecipes(for: inputItem) { recipeIndex, recipe in
                let inputItems = recipe.inputs.map(\.item)
                
                for inputItem in inputItems {
                    guard
                        !production.inputItemsContains(item: inputItem),
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
                            production.addRecipe(recipe, to: inputItem)
                        }
                    }
                    
                    if addPinnedRecipe, !isNaturalResource {
                        let pinnedRecipeIDs = storageService.pinnedRecipeIDs(for: inputItem, as: [.output, .byproduct])
                        if
                            pinnedRecipeIDs.count == 1,
                            let recipe = pinnedRecipeIDs.first.flatMap(storageService.recipe(id:)),
                            !recipe.id.contains("packaged")
                        {
                            production.addRecipe(recipe, to: inputItem)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Can perform actions
    @MainActor
    func canAdjustItem(_ outputItem: SHSingleItemProduction.OutputItem) -> Bool {
        byproductSelectionState == nil &&
        (outputItem.item.id != item.id ||
        storageService.recipes(for: outputItem.item, as: [.output, .byproduct]).count > 1)
    }
    
    func canRemoveItem(_ item: some Item) -> Bool {
        item.id != self.item.id
    }
    
    func canSelectRecipe(for input: SHSingleItemProduction.OutputRecipe.InputIngredient) -> Bool {
        !production.inputItemsContains(item: input.item) &&
        !storageService.recipes(for: input.item, as: [.output, .byproduct]).isEmpty
    }
    
    @MainActor
    func canSelectByproductProducer(byproduct: SHSingleItemProduction.OutputRecipe.ByproductIngredient) -> Bool {
        // If producing recipe is not yet selected
        byproductSelectionState?.producingRecipe == nil &&
        
        // If production has at least one input with the same item
        production.outputRecipesContains {
            !production.hasConsumer(byproduct.item, recipe: $0.recipe) &&
            $0.inputs.contains { $0.item.id == byproduct.item.id }
        }
    }
    
    @MainActor
    func canUnselectByproductProducer(
        byproduct: SHSingleItemProduction.OutputRecipe.ByproductIngredient,
        recipe: Recipe
    ) -> Bool {
        production.hasProducer(byproduct.item, recipe: recipe)
    }
    
    @MainActor
    func canSelectByproductConsumer(input: SHSingleItemProduction.OutputRecipe.InputIngredient) -> Bool {
        // If consuming recipe is not yet selected
        byproductSelectionState?.consumingRecipe == nil &&
        
        production.outputRecipesContains {
            !production.hasProducer(input.item, recipe: $0.recipe) &&
            $0.byproducts.contains { $0.item.id == input.item.id }
        }
    }
    
    @MainActor
    func canUnselectByproductConsumer(
        input: SHSingleItemProduction.OutputRecipe.InputIngredient,
        recipe: Recipe
    ) -> Bool {
        production.hasConsumer(input.item, recipe: recipe)
    }
    
    // MARK: Perform actions
    func adjustItem(_ outputItem: SHSingleItemProduction.OutputItem) {
        modalNavigationState = .adjustItem(
            viewModel: ProductAdjustmentViewModel(
                product: outputItem,
                allowDeletion: outputItem.item.id != item.id
            ) { [weak self] outputItem in
                guard let self else { return }
                
                if outputItem.recipes.isEmpty {
                    production.removeInputItem(outputItem.item)
                    explicitlyDeletedItemIDs.insert(outputItem.item.id)
                } else {
                    production.updateInputItem(outputItem)
                }
                
                modalNavigationState = nil
                update()
            }
        )
    }
    
    func removeItem(_ item: some Item) {
        production.removeInputItem(item)
        explicitlyDeletedItemIDs.insert(item.id)
        update()
        
        canBeDismissedWithoutSaving = false
    }
    
    @MainActor
    func selectRecipe(for ingredient: SHSingleItemProduction.OutputRecipe.InputIngredient) {
        let viewModel = InitialRecipeSelectionViewModel(item: ingredient.item) { [weak self] recipe in
            guard let self else { return }
            
            modalNavigationState = nil
            addRecipe(recipe, to: ingredient.item)
            update()
        }
        
        modalNavigationState = .selectInitialRecipeForItem(viewModel: viewModel)
    }
    
    @MainActor
    func selectByproductProducer(byproduct: SHSingleItemProduction.OutputRecipe.ByproductIngredient, recipe: Recipe) {
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
    func unselectByproductProducer(byproduct: SHSingleItemProduction.OutputRecipe.ByproductIngredient, recipe: Recipe) {
        production.removeProducer(recipe, for: byproduct.item)
        
        update()
    }
    
    @MainActor
    func selectByproductConsumer(input: SHSingleItemProduction.OutputRecipe.InputIngredient, recipe: Recipe) {
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
    func unselectByproductConsumer(input: SHSingleItemProduction.OutputRecipe.InputIngredient, recipe: Recipe) {
        production.removeConsumer(recipe, for: input.item)
        
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
        
        production.addByproduct(item, producer: producingRecipe, consumer: consumingRecipe)
        update()
        
        canBeDismissedWithoutSaving = false
    }
    
    // MARK: ViewModels
    @MainActor
    func buildOutputItemViewModels() {
        outputItemViewModels = production.outputItems.map { outputItem in
            ProductViewModel(
                product: outputItem,
                selectedByproduct: byproductSelectionState,
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
extension CalculationViewModel {
    enum Action {
        case adjust(SHSingleItemProduction.OutputItem)
        case removeItem(any Item)
        case selectRecipeForInput(SHSingleItemProduction.OutputRecipe.InputIngredient)
        case selectByproductProducer(
            byproduct: SHSingleItemProduction.OutputRecipe.ByproductIngredient,
            recipe: Recipe
        )
        case unselectByproductProducer(
            byproduct: SHSingleItemProduction.OutputRecipe.ByproductIngredient,
            recipe: Recipe
        )
        case selectByproductConsumer(
            input: SHSingleItemProduction.OutputRecipe.InputIngredient,
            recipe: Recipe
        )
        case unselectByproductConsumer(
            input: SHSingleItemProduction.OutputRecipe.InputIngredient,
            recipe: Recipe
        )
    }
}

// MARK: ModalNavigationState
extension CalculationViewModel {
    enum ModalNavigationState: Identifiable {
        case selectInitialRecipeForItem(viewModel: InitialRecipeSelectionViewModel)
        case adjustItem(viewModel: ProductAdjustmentViewModel)
        
        var id: String {
            switch self {
            case let .selectInitialRecipeForItem(viewModel): viewModel.item.id
            case let .adjustItem(viewModel): viewModel.id.uuidString
            }
        }
    }
}

// MARK: ByproductSelectionState
extension CalculationViewModel {
    struct ByproductSelectionState {
        let item: any Item
        var producingRecipe: Recipe?
        var consumingRecipe: Recipe?
    }
}
