import Foundation
import Observation
import SHModels
import SHStorage

@Observable
final class ProductAdjustmentViewModel: Identifiable {
    let product: SingleItemProduction.Output.Product
    let allowDeletion: Bool
    private(set) var production: SingleItemProduction
    private var output: SingleItemProduction.Output
    private let onApply: @MainActor (SingleItemProduction.UserInput.Product) -> Void
    
    var id: UUID {
        product.id
    }
    
    var amount: Double {
        production.userInput.amount
    }
    
    var hasUnselectedRecipes: Bool {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.recipes(for: product.item, as: [.output, .byproduct]).count != output.products.first?.recipes.count
    }
    
    var selectedRecipes: [SingleItemProduction.Output.Recipe] {
        output.products.first?.recipes ?? []
    }
    
    init(
        product: SingleItemProduction.Output.Product,
        allowDeletion: Bool,
        onApply: @escaping @MainActor (SingleItemProduction.UserInput.Product) -> Void
    ) {
        self.product = product
        self.allowDeletion = allowDeletion
        let production = SingleItemProduction(item: product.item)
        production.userInput.amount = product.amount
        for recipe in product.recipes {
            production.addRecipe(recipe.model, with: recipe.proportion, to: product.item)
        }
        self.production = production
        output = production.update()
        self.onApply = onApply
    }
    
    @MainActor
    func removeRecipe(_ recipe: SingleItemProduction.Output.Recipe) {
        production.userInput.products[0].recipes.removeAll {
            $0.recipe.id == recipe.model.id
        }
        
        defer {
            update()
        }
        
        guard case let .fraction(fraction) = recipe.proportion else { return }
        
        for (index, recipe) in production.userInput.products[0].recipes.enumerated() {
            switch recipe.proportion {
            case let .fraction(recipeFraction):
                production.userInput.products[0].recipes[index].proportion = .fraction(recipeFraction / (1 - fraction))
            case .fixed:
                break
            case .auto:
                break
            }
        }
    }
    
    @MainActor
    func addRecipe(_ recipe: Recipe) {
        production.addRecipe(recipe, with: .auto, to: production.userInput.products[0].item)
        update()
    }
    
    @MainActor
    func updateRecipe(
        _ recipe: SingleItemProduction.Output.Recipe,
        with proportion: ProductionProportion
    ) {
        if let index = production.userInput.products[0].recipes.firstIndex(where: { $0.recipe.id == recipe.model.id }) {
            production.userInput.products[0].recipes[index].proportion = proportion
        }
        
        update()
    }
    
    @MainActor
    func apply() {
        onApply(production.userInput.products[0])
    }
    
    @MainActor
    var unselectedItemRecipesViewModel: ItemRecipesViewModel {
        ItemRecipesViewModel(
            item: product.item,
            filterOutRecipeIDs: output.products.first?.recipes.map(\.model.id) ?? [],
            onRecipeSelected: addRecipe
        )
    }
    
    @MainActor
    private func update() {
        output = production.update()
    }
}
