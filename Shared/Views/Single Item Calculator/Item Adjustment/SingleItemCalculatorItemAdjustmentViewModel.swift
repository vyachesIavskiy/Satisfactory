import SwiftUI
import TipKit
import SHModels
import SHStorage
import SHSingleItemCalculator
import SHUtils

@Observable
final class SingleItemCalculatorItemAdjustmentViewModel: Identifiable {
    let part: SingleItemCalculator.OutputPart
    let excludingParts: [Part]
    let allowDeletion: Bool
    let addMoreRecipesTip: AddMoreRecipesTip
    private let onApply: @MainActor (SingleItemProduction.InputPart) -> Void
    
    private(set) var production: SingleItemCalculator
    
    private var proportionsValidation = ProportionsValidation()
    
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    var id: UUID {
        part.id
    }
    
    var amount: Double {
        production.amount
    }
    
    var hasUnselectedRecipes: Bool {
        @Dependency(\.storageService)
        var storageService
        
        let storedRecipes = storageService.recipes(for: part.part, as: [.output, .byproduct])
        let selectedRecipes = production.outputRecipes(for: part.part)
        return storedRecipes.count != selectedRecipes.count
    }
    
    var selectedRecipes: [SingleItemCalculator.OutputRecipe] {
        production.outputRecipes(for: part.part)
    }
    
    var pinnedRecipes: [Recipe] {
        recipes(pinned: true)
    }
    
    var unselectedRecipes: [Recipe] {
        recipes(pinned: false)
    }
    
    var applyButtonDisabled: Bool {
        !proportionsValidation.isValid
    }
    
    var validationMessage: LocalizedStringKey? {
        proportionsValidation.validationMessage
    }
    
    init(
        part: SingleItemCalculator.OutputPart,
        excludeRecipesForParts excludingParts: [Part] = [],
        allowDeletion: Bool,
        onApply: @escaping @MainActor (SingleItemProduction.InputPart) -> Void
    ) {
        self.part = part
        self.excludingParts = excludingParts
        self.allowDeletion = allowDeletion
        self.addMoreRecipesTip = AddMoreRecipesTip(part: part.part)
        let production = SingleItemCalculator(part: part.part)
        production.amount = part.amount
        for recipe in part.recipes {
            production.addRecipe(recipe.recipe, to: part.part, with: recipe.proportion)
        }
        self.production = production
        self.onApply = onApply
        production.update()
        
        @Dependency(\.storageService)
        var storageService
    }
    
    @MainActor
    func observePins() async {
        for await _ in storageService.streamPinnedRecipeIDs(for: part.part, as: [.output, .byproduct]) {
            update()
        }
    }
    
    @MainActor
    func removeRecipe(_ recipe: SingleItemCalculator.OutputRecipe) {
        production.production.inputParts[0].recipes.removeAll {
            $0.recipe == recipe.recipe
        }
        
        defer {
            update()
        }
        
        guard case let .fraction(fraction) = recipe.proportion else { return }
        
        for recipe in production.production.inputParts[0].recipes {
            switch recipe.proportion {
            case let .fraction(recipeFraction):
                production.changeProportion(
                    of: recipe.recipe,
                    for: part.part,
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
        addMoreRecipesTip.invalidate(reason: .actionPerformed)
        production.addRecipe(recipe, to: part.part)
        update()
    }
    
    @MainActor
    func updateRecipe(
        _ recipe: SingleItemCalculator.OutputRecipe,
        with proportion: Proportion
    ) {
        production.changeProportion(of: recipe.recipe, for: part.part, to: proportion)
        update()
    }
    
    @MainActor
    func apply() {
        onApply(production.production.inputParts[0])
    }
    
    @MainActor
    func recipeAdjustmentViewModel(
        recipe: SingleItemCalculator.OutputRecipe,
        index: Int
    ) -> RecipeAdjustmentViewModel {
        RecipeAdjustmentViewModel(
            recipe: recipe,
            itemAmount: amount,
            allowAdjustment: selectedRecipes.count > 1,
            allowDeletion: allowDeletion || selectedRecipes.count > 1,
            showRecipeProportionTip: index == 0
        ) { [weak self] proportion in
            self?.updateRecipe(recipe, with: proportion)
        } onDelete: { [weak self] in
            withAnimation {
                self?.removeRecipe(recipe)
            }
        }
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
    
    private func recipes(pinned: Bool) -> [Recipe] {
        let outputRecipes = storageService.recipes(for: part.part, as: .output)
        let byproductRecipes = storageService.recipes(for: part.part, as: .byproduct)
            .filter { recipe in
                !excludingParts.contains { $0.id == recipe.output.part.id }
            }
        
        let allRecipes = outputRecipes + byproductRecipes
        let pinnedIDs = storageService.pinnedRecipeIDs(for: part.part, as: [.output, .byproduct])
        
        return allRecipes.filter { recipe in
            pinnedIDs.contains(recipe.id) == pinned &&
            !selectedRecipes.contains { $0.recipe.id == recipe.id }
        }
    }
}

extension SingleItemCalculatorItemAdjustmentViewModel {
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
            guard amountOfAuto == 0, totalFractionAmount > 0, totalFixedAmount > 0 else {
                // If both values are 0, we do not have any recipes selected
                return true
            }
            
            // Fractions are higher than 100%
            return if totalFractionAmount > 1.0 { false }
            
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
            guard amountOfAuto == 0, totalFractionAmount > 0, totalFixedAmount > 0 else {
                return nil
            }
            
            return if totalFractionAmount > 1.0 {
                "product-adjustment-fraction-\(totalFractionAmount, format: .shPercent)-exceeds-\(1, format: .shPercent)"
            } else if totalFixedAmount > availableAmount {
                "product-adjustment-fixed-\(totalFixedAmount, format: .shNumber())-exceeds-\(availableAmount, format: .shNumber())"
            } else if amountOfAuto == 0, totalFractionAmount > 0, totalFractionAmount < 1.0 {
                "product-adjustment-fractions-\(totalFractionAmount, format: .shPercent)-should-be-exactly-\(1, format: .shPercent)"
            } else if amountOfAuto == 0, totalFractionAmount == 0.0, totalFixedAmount != availableAmount {
                "product-adjustment-fixed-\(totalFixedAmount, format: .shNumber())-should-be-equal-to-available-\(availableAmount, format: .shNumber())"
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

extension SingleItemCalculatorItemAdjustmentViewModel {
    struct AddMoreRecipesTip: Tip {
        let part: Part
        
        var title: Text {
            Text("single-item-production-tip-add-more-recipes-title-\(part.localizedName)")
        }
        
        var message: Text? {
            Text("single-item-production-tip-add-more-recipes-message")
        }
    }
}
