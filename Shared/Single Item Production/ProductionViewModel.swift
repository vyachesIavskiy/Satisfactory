import Observation
import SHModels
import SHStorage
import SHSingleItemProduction

enum SingleProductionAction {
    case adjust(SHSingleItemProduction.OutputItem)
    case selectRecipeForInput(SHSingleItemProduction.OutputRecipe.InputIngredient)
    case selectByproductProducer(
        product: SHSingleItemProduction.OutputItem,
        ingredient: SHSingleItemProduction.OutputRecipe.OutputIngredient,
        recipe: Recipe
    )
    case selectByproductConsumer(input: SHSingleItemProduction.OutputRecipe.InputIngredient, recipe: Recipe)
}

@Observable
final class ProductionViewModel {
    struct ByproductSelection {
        let item: any Item
        var producingRecipe: Recipe?
        var consumingRecipe: Recipe?
    }
    
    enum Step: Equatable {
        // An initial step for a production.
        case selectingInitialRecipe
        
        // A production state. An initial recipe is selected and a system is waiting for a user input.
        case production
    }
    
    @ObservationIgnored
    private var production: SHSingleItemProduction
    
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    @ObservationIgnored @Dependency(\.settingsService)
    private var settingsService
    
    var selectedProduct: SHSingleItemProduction.OutputItem?
    var selectedNewItemID: String?
    var selectedByproduct: ByproductSelection?
    var showUnsavedAlert = false
    
    var item: any Item {
        production.item
    }
    
    @MainActor
    var amount: Double {
        get { production.amount }
        set {
            guard newValue != production.amount else { return }
            production.amount = newValue
            update()
        }
    }
    
    var step = Step.selectingInitialRecipe
    
    var hasUnsavedChanges: Bool {
        // TODO: Check for unsaved changes
        true
    }
    
    @MainActor
    init(item: some Item) {
        @Dependency(\.storageService)
        var storageService
        
        production = SHSingleItemProduction(item: item)
        
        addAutomaticInitialRecipeIfNeeded()
    }
    
    @MainActor
    func update() {
        production.update()
    }

    func unselectedRecipes(for item: some Item) -> [Recipe] {
        @Dependency(\.storageService)
        var storageService
        
        var recipes = storageService.recipes(for: item, as: [.output, .byproduct])
        if let product = production.output.products.first(where: { $0.item.id == item.id }) {
            recipes = recipes.filter { !product.recipes.map(\.recipe.id).contains($0.id) }
        }
        
        return recipes
    }
    
    @MainActor
    func addInitialRecipe(_ recipe: Recipe) {
        amount = recipe.amountPerMinute(for: recipe.output)
        production.addRecipe(recipe, to: item)
        addAutomaticallySelectedRecipesIfNeeded()
        update()
        step = .production
    }
    
    @MainActor
    func addRecipe(_ recipe: Recipe, to item: some Item) {
        production.addRecipe(recipe, to: item)
        addAutomaticallySelectedRecipesIfNeeded()
        update()
    }
    
    @MainActor
    func adjustProduct(_ product: SHSingleItemProduction.OutputItem) {
        selectedProduct = product
    }
    
    private func addAutomaticallySelectedRecipesIfNeeded() {
        let shouldAddSingleRecipe = settingsService.autoSelectSingleRecipe
        let shouldAddSinglePinnedRecipe = settingsService.autoSelectSinglePinnedRecipe
        
        guard shouldAddSingleRecipe || shouldAddSinglePinnedRecipe else { return }
        
        production.iterateInputItems { productIndex, item in
            production.iterateInputRecipes(for: item) { recipeIndex, recipe in
                let inputItems = recipe.inputs.map(\.item)
                
                for inputItem in inputItems {
                    guard !production.inputContains(inputItem) else { continue }
                    
                    let inputItemRecipes = storageService.recipes(for: inputItem, as: [.output, .byproduct])
                    if shouldAddSingleRecipe, inputItemRecipes.count == 1, let recipeToAdd = inputItemRecipes.first {
                        production.addRecipe(recipeToAdd, to: inputItem)
                    }
                    
                    let inputItemPinnedRecipeIDs = storageService.pinnedRecipeIDs(for: inputItem, as: [.output, .byproduct])
                    if
                        shouldAddSinglePinnedRecipe,
                        inputItemPinnedRecipeIDs.count == 1,
                        let recipeID = inputItemPinnedRecipeIDs.first,
                        let recipeToAdd = storageService.recipe(for: recipeID)
                    {
                        production.addRecipe(recipeToAdd, to: inputItem)
                    }
                }
            }
        }
    }
    
    @MainActor
    private func addAutomaticInitialRecipeIfNeeded() {
        let shouldAddSingleRecipe = settingsService.autoSelectSingleRecipe
        let shouldAddSinglePinnedRecipe = settingsService.autoSelectSinglePinnedRecipe
        
        let inputItemRecipes = storageService.recipes(for: item, as: [.output, .byproduct])
        if shouldAddSingleRecipe, inputItemRecipes.count == 1, let recipeToAdd = inputItemRecipes.first {
            addInitialRecipe(recipeToAdd)
        }
        
        let inputItemPinnedRecipeIDs = storageService.pinnedRecipeIDs(for: item, as: [.output, .byproduct])
        if
            shouldAddSinglePinnedRecipe,
            inputItemPinnedRecipeIDs.count == 1,
            let recipeID = inputItemPinnedRecipeIDs.first,
            let recipeToAdd = storageService.recipe(for: recipeID)
        {
            addInitialRecipe(recipeToAdd)
        }
    }
    
    @MainActor
    func initialRecipeSelectionViewModel() -> SingleItemProductionInitialRecipeSelectionViewModel {
        SingleItemProductionInitialRecipeSelectionViewModel(item: item, onRecipeSelected: addInitialRecipe)
    }
    
    @MainActor
    func productViewModel(for product: SHSingleItemProduction.OutputItem) -> ProductViewModel {
        ProductViewModel(
            product: product,
            selectedByproduct: selectedByproduct,
            canPerformAction: { [weak self] action in
                guard let self else { return false }
                
                return switch action {
                case let .adjust(product):
                    canAdjustProduct(product)
                    
                case let .selectRecipeForInput(input):
                    !production.inputContains(input.item)
                    
                case let .selectByproductProducer(product, ingredient, _):
                    selectedByproduct?.producingRecipe == nil &&
                    !production.output.products.contains {
                        $0.recipes.contains {
                            $0.inputs.contains { $0.producingProductID == product.id }
                        }
                    } &&
                    production.inputContains {
                        $0.recipes.contains {
                            $0.inputs.contains { $0.item.id == ingredient.item.id }
                        }
                    }
                    
                case let .selectByproductConsumer(input, _):
                    selectedByproduct?.consumingRecipe == nil &&
                    !production.output.products.contains { $0.id == input.producingProductID } &&
                    production.inputContains {
                        $0.recipes.contains {
                            $0.output.item.id == input.item.id ||
                            $0.byproducts.contains { $0.item.id == input.item.id }
                        }
                    }
                }
            },
            performAction: { [weak self] action in
                guard let self else { return }
                
                switch action {
                case let .adjust(product):
                    adjustProduct(product)
                    
                case let .selectRecipeForInput(input):
                    selectedNewItemID = input.item.id
                    
                case let .selectByproductProducer(_, ingredient, recipe):
                    if selectedByproduct == nil {
                        selectedByproduct = ByproductSelection(item: ingredient.item, producingRecipe: recipe)
                    } else {
                        selectedByproduct?.producingRecipe = recipe
                    }
                    
                    checkByproductState()
                    
                case let .selectByproductConsumer(input, recipe):
                    if selectedByproduct == nil {
                        selectedByproduct = ByproductSelection(item: input.item, consumingRecipe: recipe)
                    } else {
                        selectedByproduct?.consumingRecipe = recipe
                    }
                    
                    checkByproductState()
                }
            }
        )
    }
    
    @MainActor
    func addInitialRecipeViewModel(for itemID: String) -> ProductionNewProductRecipeSelectionViewModel {
        let item = storageService.item(withID: itemID)!
        
        return ProductionNewProductRecipeSelectionViewModel(item: item, selectedRecipeIDs: []) { [weak self] recipe in
            self?.addRecipe(recipe, to: item)
            self?.selectedNewItemID = nil
        }
    }
    
    @MainActor
    func productAdjustmentViewModel(for product: SHSingleItemProduction.OutputItem) -> ProductAdjustmentViewModel {
        ProductAdjustmentViewModel(product: product, allowDeletion: product.item.id != item.id) { [weak self] product in
            guard let self else { return }
            
            if product.recipes.isEmpty {
                production.removeInputItem(product.item)
            } else {
                production.updateInputItem(product)
            }
            
            selectedProduct = nil
            update()
        }
    }
    
    func canAdjustProduct(_ product: SHSingleItemProduction.OutputItem) -> Bool {
        storageService.recipes(for: product.item, as: [.output, .byproduct]).count > 1
    }
    
    @MainActor
    func productViewModels() -> [ProductViewModel] {
        if let selectedByproduct {
            production.output.products.compactMap { product in
                let visibleRecipes = product.recipes.filter { recipe in
                    if let producingRecipeID = selectedByproduct.producingRecipe?.id {
                        recipe.recipe.id == producingRecipeID || recipe.recipe.inputs.contains { $0.item.id == selectedByproduct.item.id }
                    } else if let consumingRecipeID = selectedByproduct.consumingRecipe?.id {
                        recipe.recipe.id == consumingRecipeID || recipe.recipe.output.item.id == selectedByproduct.item.id || recipe.recipe.byproducts.contains { $0.item.id == selectedByproduct.item.id }
                    } else {
                        false
                    }
                }
                
                guard !visibleRecipes.isEmpty else { return nil }
                
                return productViewModel(for: SHSingleItemProduction.OutputItem(item: product.item, recipes: visibleRecipes))
            }
        } else {
            production.output.products.map(productViewModel(for:))
        }
    }
    
    @MainActor
    func checkByproductState() {
        guard
            let item = selectedByproduct?.item,
            let producingRecipe = selectedByproduct?.producingRecipe,
            let consumingRecipe = selectedByproduct?.consumingRecipe
        else { return }
        
        selectedByproduct = nil
        
        production.addByproduct(item, producer: producingRecipe, consumer: consumingRecipe)
        update()
    }
    
    @MainActor
    func saveProduction() {
        // TODO: Save production
    }
}
