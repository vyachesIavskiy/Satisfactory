import Foundation
import Observation
import SHModels
import SHStorage
import SHSingleItemProduction

@Observable
final class ProductAdjustmentViewModel: Identifiable {
    let product: SingleItemProduction.Output.Product
    let allowDeletion: Bool
    private(set) var production: SingleItemProduction
    private let onApply: @MainActor (SingleItemProduction.UserInput.Product) -> Void
    
    var id: UUID {
        product.id
    }
    
    var amount: Double {
        production.amount
    }
    
    var hasUnselectedRecipes: Bool {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.recipes(for: product.item, as: [.output, .byproduct]).count != production.output.products.first?.recipes.count
    }
    
    var selectedRecipes: [SingleItemProduction.Output.Recipe] {
        production.output.products.first?.recipes ?? []
    }
    
    init(
        product: SingleItemProduction.Output.Product,
        allowDeletion: Bool,
        onApply: @escaping @MainActor (SingleItemProduction.UserInput.Product) -> Void
    ) {
        self.product = product
        self.allowDeletion = allowDeletion
        let production = SingleItemProduction(item: product.item)
        production.amount = product.amount
        for recipe in product.recipes {
            production.addRecipe(recipe.model, to: product.item, with: recipe.proportion)
        }
        self.production = production
        self.onApply = onApply
        production.update()
    }
    
    @MainActor
    func removeRecipe(_ recipe: SingleItemProduction.Output.Recipe) {
        production[inputItemIndex: 0].recipes.removeAll {
            $0.recipe.id == recipe.model.id
        }
        
        defer {
            update()
        }
        
        guard case let .fraction(fraction) = recipe.proportion else { return }
        
        for recipe in production[inputItemIndex: 0].recipes {
            switch recipe.proportion {
            case let .fraction(recipeFraction):
                production.changeProportion(
                    of: recipe.recipe,
                    for: product.item,
                    to: .fraction(recipeFraction / (1 - fraction))
                )
            case .fixed:
                break
            case .auto:
                break
            }
        }
    }
    
    @MainActor
    func addRecipe(_ recipe: Recipe) {
        production.addRecipe(recipe, to: product.item)
        update()
    }
    
    @MainActor
    func updateRecipe(
        _ recipe: SingleItemProduction.Output.Recipe,
        with proportion: ProductionProportion
    ) {
        production.changeProportion(of: recipe.model, for: product.item, to: proportion)
        update()
    }
    
    @MainActor
    func apply() {
        onApply(production[inputItemIndex: 0])
    }
    
    @MainActor
    var unselectedItemRecipesViewModel: SingleItemProductionInitialRecipeSelectionViewModel {
        SingleItemProductionInitialRecipeSelectionViewModel(
            item: product.item,
            filterOutRecipeIDs: production.output.products.first?.recipes.map(\.model.id) ?? [],
            onRecipeSelected: addRecipe
        )
    }
    
    @MainActor
    private func update() {
        production.update()
    }
}
