import Foundation
import Observation
import SHModels
import SHStorage
import SHSingleItemProduction

@Observable
final class ProductAdjustmentViewModel: Identifiable {
    let product: SHSingleItemProduction.OutputItem
    let allowDeletion: Bool
    private let onApply: @MainActor (SHSingleItemProduction.InputItem) -> Void
    
    private(set) var production: SHSingleItemProduction
    
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    var id: UUID {
        product.id
    }
    
    var amount: Double {
        production.amount
    }
    
    var hasUnselectedRecipes: Bool {
        @Dependency(\.storageService)
        var storageService
        
        let storedRecipes = storageService.recipes(for: product.item, as: [.output, .byproduct])
        let selectedRecipes = production.outputRecipes(for: product.item)
        return storedRecipes.count != selectedRecipes.count
    }
    
    var selectedRecipes: [SHSingleItemProduction.OutputRecipe] {
        production.outputRecipes(for: product.item)
    }
    
    var pinnedRecipes: [Recipe] {
        let allRecipes = storageService.recipes(for: product.item, as: [.output, .byproduct])
        let pinnedIDs = storageService.pinnedRecipeIDs(for: product.item, as: [.output, .byproduct])
        
        return allRecipes.filter { recipe in
            pinnedIDs.contains(recipe.id) && !selectedRecipes.contains { $0.recipe.id == recipe.id }
        }
    }
    
    var unselectedRecipes: [Recipe] {
        let allRecipes = storageService.recipes(for: product.item, as: [.output, .byproduct])
        let pinnedIDs = storageService.pinnedRecipeIDs(for: product.item, as: [.output, .byproduct])
        
        return allRecipes.filter { recipe in
            !pinnedIDs.contains(recipe.id) && !selectedRecipes.contains { $0.recipe.id == recipe.id }
        }
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
        
        @Dependency(\.storageService)
        var storageService
    }
    
    @MainActor
    func observePins() async {
        for await _ in storageService.streamPinnedRecipeIDs(for: product.item, as: [.output, .byproduct]) {
            update()
        }
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
        with proportion: Proportion
    ) {
        production.changeProportion(of: recipe.recipe, for: product.item, to: proportion)
        update()
    }
    
    @MainActor
    func apply() {
        onApply(production[inputItemIndex: 0])
    }
    
    @MainActor
    private func update() {
        _$observationRegistrar.withMutation(of: self, keyPath: \.production) {
            production.update()
        }
    }
}
