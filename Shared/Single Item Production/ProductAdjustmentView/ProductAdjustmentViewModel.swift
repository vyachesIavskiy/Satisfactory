import Foundation
import Observation
import SHModels
import SHStorage
import SHSingleItemProduction

@Observable
final class ProductAdjustmentViewModel: Identifiable {
    let product: SHSingleItemProduction.OutputItem
    let allowDeletion: Bool
    private(set) var production: SHSingleItemProduction
    private let onApply: @MainActor (SHSingleItemProduction.InputItem) -> Void
    
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
    
    var selectedRecipes: [SHSingleItemProduction.OutputRecipe] {
        production.output.products.first?.recipes ?? []
    }
    
    init(
        product: SHSingleItemProduction.OutputItem,
        allowDeletion: Bool,
        onApply: @escaping @MainActor (SHSingleItemProduction.InputItem) -> Void
    ) {
        self.product = product
        self.allowDeletion = allowDeletion
        let production = SHSingleItemProduction(item: product.item)
        production.amount = product.amount
        for recipe in product.recipes {
            production.addRecipe(recipe.recipe, to: product.item, with: recipe.proportion)
        }
        self.production = production
        self.onApply = onApply
        production.update()
    }
    
    @MainActor
    func removeRecipe(_ recipe: SHSingleItemProduction.OutputRecipe) {
        production[inputItemIndex: 0].recipes.removeAll {
            $0.id == recipe.recipe.id
        }
        
        defer {
            update()
        }
        
        guard case let .fraction(fraction) = recipe.proportion else { return }
        
        for recipe in production[inputItemIndex: 0].recipes {
            switch recipe.proportion {
            case let .fraction(recipeFraction):
                production.changeProportion(
                    of: recipe,
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
        _ recipe: SHSingleItemProduction.OutputRecipe,
        with proportion: SHProductionProportion
    ) {
        production.changeProportion(of: recipe.recipe, for: product.item, to: proportion)
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
            filterOutRecipeIDs: production.output.products.first?.recipes.map(\.recipe.id) ?? [],
            onRecipeSelected: addRecipe
        )
    }
    
    @MainActor
    private func update() {
        production.update()
    }
}
