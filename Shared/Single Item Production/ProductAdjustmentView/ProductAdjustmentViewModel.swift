import SwiftUI
import SHModels
import SHStorage
import SingleItemCalculator

@Observable
final class ProductAdjustmentViewModel: Identifiable {
    let product: SingleItemCalculator.OutputItem
    let allowDeletion: Bool
    private let onApply: @MainActor (SingleItemProduction.InputItem) -> Void
    
    private(set) var production: SingleItemCalculator
    
    private var proportionsValidation = ProportionsValidation()
    
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
    
    var selectedRecipes: [SingleItemCalculator.OutputRecipe] {
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
    
    var applyButtonDisabled: Bool {
        !proportionsValidation.isValid
    }
    
    var validationMessage: LocalizedStringKey? {
        proportionsValidation.validationMessage
    }
    
    init(
        product: SingleItemCalculator.OutputItem,
        allowDeletion: Bool,
        onApply: @escaping @MainActor (SingleItemProduction.InputItem) -> Void
    ) {
        self.product = product
        self.allowDeletion = allowDeletion
        let production = SingleItemCalculator(item: product.item)
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
    func removeRecipe(_ recipe: SingleItemCalculator.OutputRecipe) {
        production.production.inputItems[0].recipes.removeAll {
            $0.recipe == recipe.recipe
        }
        
        defer {
            update()
        }
        
        guard case let .fraction(fraction) = recipe.proportion else { return }
        
        for recipe in production.production.inputItems[0].recipes {
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
        _ recipe: SingleItemCalculator.OutputRecipe,
        with proportion: Proportion
    ) {
        production.changeProportion(of: recipe.recipe, for: product.item, to: proportion)
        update()
    }
    
    @MainActor
    func apply() {
        onApply(production.production.inputItems[0])
    }
    
    @MainActor
    private func update() {
        _$observationRegistrar.withMutation(of: self, keyPath: \.production) {
            production.update()
        }
        
        let recipeAmounts = selectedRecipes.reduce(into: (0, 0.0, 0.0)) { partialResult, recipe in
            switch recipe.proportion {
            case .auto: partialResult.0 += 1
            case let .fraction(fraction): partialResult.1 += fraction
            case let .fixed(fixedAmount): partialResult.2 += fixedAmount
            }
        }
        
        proportionsValidation = ProportionsValidation(
            amountOfAuto: recipeAmounts.0,
            totalFractionAmount: recipeAmounts.1,
            totalFixedAmount: recipeAmounts.2,
            availableAmount: amount
        )
    }
}

extension ProductAdjustmentViewModel {
    struct ProportionsValidation {
        struct ValidationMessage: Identifiable, Hashable {
            let id = UUID()
            let message: LocalizedStringKey
            
            func hash(into hasher: inout Hasher) {
                hasher.combine(id)
            }
        }
        
        var amountOfAuto: Int
        var totalFractionAmount: Double
        var totalFixedAmount: Double
        var availableAmount: Double
        
        var isValid: Bool {
            // Fractions are higher than 100%
            if totalFractionAmount > 1.0 { false }
            
            // Fixed are higher that total available amount
            else if totalFixedAmount > availableAmount { false }
            
            // There is no auto, but there are fractions and they do not make 100% in total
            else if amountOfAuto == 0, totalFractionAmount > 0, totalFractionAmount < 1.0 { false }
            
            // There is no auto, no fractions and fixed amounts are not equal to total available amounts
            else if amountOfAuto == 0, totalFractionAmount == 0.0, totalFixedAmount != availableAmount { false }
            
            // Otherwise it's fine
            else { true }
        }
        
        var validationMessage: LocalizedStringKey? {
            if totalFractionAmount > 1.0 {
                "product-adjustment-fraction-\(totalFractionAmount, format: .shPercent)-exceeds-\(1, format: .shPercent)"
            } else if totalFixedAmount > availableAmount {
                "product-adjustment-fixed-\(totalFixedAmount, format: .shNumber)-exceeds-\(availableAmount, format: .shNumber)"
            } else if amountOfAuto == 0, totalFractionAmount > 0, totalFractionAmount < 1.0 {
                "product-adjustment-fractions-\(totalFractionAmount, format: .shPercent)-should-be-exactly-\(1, format: .shPercent)"
            } else if amountOfAuto == 0, totalFractionAmount == 0.0, totalFixedAmount != availableAmount {
                "product-adjustment-fixed-\(totalFixedAmount, format: .shNumber)-should-be-equal-to-available-\(availableAmount, format: .shNumber)"
            } else {
                nil
            }
        }
        
        init(
            amountOfAuto: Int = 0,
            totalFractionAmount: Double = 0.0,
            totalFixedAmount: Double = 0.0,
            availableAmount: Double = 0.0
        ) {
            self.amountOfAuto = amountOfAuto
            self.totalFractionAmount = totalFractionAmount
            self.totalFixedAmount = totalFixedAmount
            self.availableAmount = availableAmount
        }
    }
}
