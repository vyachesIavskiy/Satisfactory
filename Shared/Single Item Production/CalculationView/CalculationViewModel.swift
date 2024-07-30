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
    
    var item: any Item {
        production.item
    }
    
    var amount: Double {
        get { production.amount }
        set {
            guard newValue != production.amount else { return }
            
            production.amount = newValue
            update()
        }
    }
    
    var hasUnsavedChanges: Bool {
        // TODO: Implement this
        true
    }
    
    // MARK: Observed properties
    var outputItemViewModels = [ProductViewModel]()
    var modalNavigationState: ModalNavigationState?
    var showingUnsavedConfirmationDialog = false
    private var byproductSelectionState: ByproductSelectionState?
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    init(item: some Item, recipe: Recipe) {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService)
        var settingsService
        
        production = SHSingleItemProduction(item: item)
        self.pins = storageService.pins()
        self.settings = settingsService.settings
        
        addInitialRecipe(recipe)
    }
    
    func addRecipe(_ recipe: Recipe, to item: some Item) {
        production.addRecipe(recipe, to: item)
        addInputRecipesIfNeeded()
        update()
    }
    
    func saveProduction() {
        
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
        production.addRecipe(recipe, to: item)
        addInputRecipesIfNeeded()
        update()
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
    
    // MARK: Update
    func update() {
        production.update()
        Task { @MainActor [weak self] in
            self?.buildOutputItemViewModels()
        }
    }
    
    // MARK: Can perform actions
    func canAdjustItem(_ outputItem: SHSingleItemProduction.OutputItem) -> Bool {
        outputItem.item.id != item.id ||
        storageService.recipes(for: outputItem.item, as: [.output, .byproduct]).count > 1
    }
    
    func canRemoveItem(_ item: some Item) -> Bool {
        item.id != self.item.id
    }
    
    func canSelectRecipe(for input: SHSingleItemProduction.OutputRecipe.InputIngredient) -> Bool {
        !production.inputItemsContains(item: input.item) &&
        !storageService.recipes(for: input.item, as: [.output, .byproduct]).isEmpty
    }
    
    func canSelectByproductProducer(
        outputItem: SHSingleItemProduction.OutputItem,
        ingredient: SHSingleItemProduction.OutputRecipe.OutputIngredient
    ) -> Bool {
        // Producing recipe is already selected
        byproductSelectionState?.producingRecipe == nil &&
        
        // outputItem is not produced by another recipe
        !production.outputRecipesContains {
            $0.inputs.contains { $0.producingProductID == outputItem.id }
        } &&
        
        // ingredient is an input of another recipe
        production.inputRecipesContains { inputRecipe in
            inputRecipe.inputs.contains { $0.item.id == ingredient.item.id }
        }
    }
    
    func canSelectByproductConsumer(ingredient: SHSingleItemProduction.OutputRecipe.InputIngredient) -> Bool {
        // Consuming recipe is already selected
        byproductSelectionState?.consumingRecipe == nil &&
        
        // ingredient is not producing an item
        !production.outputItemsContains { $0.id == ingredient.producingProductID } &&
        
        // ingredient is either output or byproduct of another selected item
        production.inputRecipesContains { inputRecipe in
            inputRecipe.output.item.id == ingredient.item.id ||
            inputRecipe.byproducts.contains { $0.item.id == ingredient.item.id }
        }
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
    
    func selectByproductProducer(ingredient: SHSingleItemProduction.OutputRecipe.OutputIngredient, recipe: Recipe) {
        if byproductSelectionState == nil {
            byproductSelectionState = ByproductSelectionState(
                item: ingredient.item,
                producingRecipe: recipe
            )
        } else {
            byproductSelectionState?.producingRecipe = recipe
        }
        
        checkByproductSelectionState()
    }
    
    func selectByproductConsumer(ingredient: SHSingleItemProduction.OutputRecipe.InputIngredient, recipe: Recipe) {
        if byproductSelectionState == nil {
            byproductSelectionState = ByproductSelectionState(
                item: ingredient.item,
                consumingRecipe: recipe
            )
        } else {
            byproductSelectionState?.consumingRecipe = recipe
        }
        
        checkByproductSelectionState()
    }
    
    func checkByproductSelectionState() {
        guard
            let item = byproductSelectionState?.item,
            let producingRecipe = byproductSelectionState?.producingRecipe,
            let consumingRecipe = byproductSelectionState?.consumingRecipe
        else { return }
        
        byproductSelectionState = nil
        
        production.addByproduct(item, producer: producingRecipe, consumer: consumingRecipe)
        update()
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
                        
                    case let .selectByproductProducer(item, ingredient, _):
                        canSelectByproductProducer(outputItem: item, ingredient: ingredient)
                        
                    case let .selectByproductConsumer(ingredient, _):
                        canSelectByproductConsumer(ingredient: ingredient)
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
                        
                    case let .selectByproductProducer(_, ingredient, recipe):
                        selectByproductProducer(ingredient: ingredient, recipe: recipe)
                        
                    case let .selectByproductConsumer(ingredient, recipe):
                        selectByproductConsumer(ingredient: ingredient, recipe: recipe)
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
            product: SHSingleItemProduction.OutputItem,
            ingredient: SHSingleItemProduction.OutputRecipe.OutputIngredient,
            recipe: Recipe
        )
        case selectByproductConsumer(input: SHSingleItemProduction.OutputRecipe.InputIngredient, recipe: Recipe)
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
