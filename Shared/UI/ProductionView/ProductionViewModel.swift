import Observation
import SHModels
import SHStorage

enum SingleProductionAction {
    case adjust(SingleItemProduction.Output.Product)
    case selectRecipeForInput(SingleItemProduction.Output.Recipe.InputIngredient)
    case selectByproductProducer(
        product: SingleItemProduction.Output.Product,
        ingredient: SingleItemProduction.Output.Recipe.OutputIngredient,
        recipe: Recipe
    )
    case selectByproductConsumer(input: SingleItemProduction.Output.Recipe.InputIngredient, recipe: Recipe)
}

@Observable
final class ProductionViewModel {
    struct ByproductSelection {
        struct RecipeWithRole {
            var recipe: Recipe
            var role: Recipe.Ingredient.Role
        }
        
        let item: any Item
        var fromRecipe: RecipeWithRole?
        var toRecipe: RecipeWithRole?
    }
    
    struct ByproductSelection2 {
        let item: any Item
        var producingRecipe: Recipe?
        var consumingRecipe: Recipe?
    }
    
    enum Step: Equatable {
        // An initial step for a production.
        case selectingInitialRecipe
        
        // An idle state. An initial recipe is selected and a system is waiting for a user input.
        case idle
        
        // Selecting a recipe for a new item
        case selectingRecipe(forItem: any Item)
        
        // Adjusting recipes for an item in production
        case adjustingProduct(SingleItemProduction.Output.Product)
        
        static func == (lhs: ProductionViewModel.Step, rhs: ProductionViewModel.Step) -> Bool {
            switch (lhs, rhs) {
            case (.selectingInitialRecipe, .selectingInitialRecipe): true
            case (.idle, .idle): true
            case let (.selectingRecipe(lhsItem), .selectingRecipe(rhsItem)): lhsItem.id == rhsItem.id
            case let (.adjustingProduct(lhsProduct), .adjustingProduct(rhsProduct)): lhsProduct == rhsProduct
                
            default: false
            }
        }
    }
    
    @ObservationIgnored
    private var production: SingleItemProduction
    
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    var output: SingleItemProduction.Output
    
    var selectedProduct: SingleItemProduction.Output.Product?
    var selectedNewItemID: String?
    var selectedByproduct: ByproductSelection?
    
    var selectedByproduct2: ByproductSelection2?
    
    var item: any Item {
        production.item
    }
    
    @MainActor
    var amount: Double {
        get { production.userInput.amount }
        set {
            guard newValue != production.userInput.amount else { return }
            production.userInput.amount = newValue
            update()
        }
    }
    
    var step = Step.selectingInitialRecipe
    
    var showingBottomSheet: Bool {
        get {
            step != .selectingInitialRecipe
        }
        set {
            // Do nothing
        }
    }
    
    @MainActor
    init(item: some Item) {
        @Dependency(\.storageService)
        var storageService
        
        production = SingleItemProduction(item: item)
        output = SingleItemProduction.Output(products: [], unselectedItems: [item], hasByproducts: false)
        
        let recipes = storageService.recipes(for: item, as: .output, .byproduct)
        if recipes.count == 1 {
            // If there is only one recipe for a selected item, select it automatically
            addInitialRecipe(recipes[0])
        }
    }
    
    @MainActor
    func update() {
        output = production.update()
    }

    func unselectedRecipes(for item: some Item) -> [Recipe] {
        @Dependency(\.storageService)
        var storageService
        
        var recipes = storageService.recipes(for: item, as: .output, .byproduct)
        if let product = output.products.first(where: { $0.item.id == item.id }) {
            recipes = recipes.filter { !product.recipes.map(\.id).contains($0.id) }
        }
        
        return recipes
    }
    
    @MainActor
    func addInitialRecipe(_ recipe: Recipe) {
        production.userInput.amount = recipe.amountPerMinute(for: recipe.output)
        production.addRecipe(recipe, with: .auto, to: item)
        update()
        step = .idle
    }
    
    @MainActor
    func addRecipe(_ recipe: Recipe, to item: some Item) {
        production.addRecipe(recipe, with: .auto, to: item)
        update()
        step = .idle
    }
    
    @MainActor
    func adjustProduct(_ product: SingleItemProduction.Output.Product) {
        selectedProduct = product
    }
    
    @MainActor
    func productViewModel(for product: SingleItemProduction.Output.Product) -> ProductViewModel {
        ProductViewModel(
            product: product,
            selectedByproduct: selectedByproduct2,
            canPerformAction: { [weak self] action in
                guard let self else { return false }
                
                return switch action {
                case let .adjust(product):
                    canAdjustProduct(product)
                    
                case let .selectRecipeForInput(input):
                    !production.userInput.products.contains { $0.item.id == input.item.id }
                    
                case let .selectByproductProducer(product, ingredient, _):
                    selectedByproduct2?.producingRecipe == nil &&
                    !output.products.contains {
                        $0.recipes.contains {
                            $0.inputs.contains { $0.producingProductID == product.id }
                        }
                    } &&
                    production.userInput.products.contains {
                        $0.recipes.contains {
                            $0.recipe.input.contains { $0.item.id == ingredient.item.id }
                        }
                    }
                    
                case let .selectByproductConsumer(input, _):
                    selectedByproduct2?.consumingRecipe == nil &&
                    !output.products.contains { $0.id == input.producingProductID } &&
                    production.userInput.products.contains {
                        $0.recipes.contains {
                            $0.recipe.output.item.id == input.item.id ||
                            $0.recipe.byproducts.contains { $0.item.id == input.item.id }
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
                    if selectedByproduct2 == nil {
                        selectedByproduct2 = ByproductSelection2(item: ingredient.item, producingRecipe: recipe)
                    } else {
                        selectedByproduct2?.producingRecipe = recipe
                    }
                    
                    checkByproductState()
                    
                case let .selectByproductConsumer(input, recipe):
                    if selectedByproduct2 == nil {
                        selectedByproduct2 = ByproductSelection2(item: input.item, consumingRecipe: recipe)
                    } else {
                        selectedByproduct2?.consumingRecipe = recipe
                    }
                    
                    checkByproductState()
                }
            }
        )
    }
    
    @MainActor
    func addInitialRecipeViewModel(for itemID: String) -> ItemRecipesViewModel {
        let item = storageService.item(for: itemID)!
        
        return ItemRecipesViewModel(item: item) { [weak self] recipe in
            self?.addRecipe(recipe, to: item)
            self?.selectedNewItemID = nil
        }
    }
    
    @MainActor
    func productAdjustmentViewModel(for product: SingleItemProduction.Output.Product) -> ProductAdjustmentViewModel {
        ProductAdjustmentViewModel(product: product, allowDeletion: product.item.id != item.id) { [weak self] product in
            guard let self else { return }
            
            if product.recipes.isEmpty {
                production.removeProduct(with: product.item)
            } else {
                production.updateProduct(product)
            }
            
            selectedProduct = nil
            update()
        }
    }
    
    func canAdjustProduct(_ product: SingleItemProduction.Output.Product) -> Bool {
        storageService.recipes(for: product.item, as: .output, .byproduct).count > 1
    }
    
    @MainActor
    func productViewModels() -> [ProductViewModel] {
        if let selectedByproduct2 {
            output.products.compactMap { product in
                let visibleRecipes = product.recipes.filter { recipe in
                    if let producingRecipeID = selectedByproduct2.producingRecipe?.id {
                        recipe.model.id == producingRecipeID || recipe.model.input.contains { $0.item.id == selectedByproduct2.item.id }
                    } else if let consumingRecipeID = selectedByproduct2.consumingRecipe?.id {
                        recipe.model.id == consumingRecipeID || recipe.model.output.item.id == selectedByproduct2.item.id || recipe.model.byproducts.contains { $0.item.id == selectedByproduct2.item.id }
                    } else {
                        false
                    }
                }
                
                guard !visibleRecipes.isEmpty else { return nil }
                
                return productViewModel(for: SingleItemProduction.Output.Product(item: product.item, recipes: visibleRecipes))
            }
        } else {
            output.products.map(productViewModel(for:))
        }
    }
    
    @MainActor
    func checkByproductState() {
        guard
            let item = selectedByproduct2?.item,
            let producingRecipe = selectedByproduct2?.producingRecipe,
            let consumingRecipe = selectedByproduct2?.consumingRecipe
        else { return }
        
        selectedByproduct2 = nil
        
        production.addByproduct(item, producer: producingRecipe, consumer: consumingRecipe)
        update()
    }
}