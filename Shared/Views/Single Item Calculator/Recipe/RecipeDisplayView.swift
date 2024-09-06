import SwiftUI
import SHSingleItemCalculator
import SHSharedUI

struct RecipeDisplayView: View {
    private let recipe: SingleItemCalculator.OutputRecipe
    
    private let gridItem = GridItem(.adaptive(minimum: 80, maximum: 100), spacing: 12)
    
    @Environment(\.displayScale)
    private var displayScale
    
    init(_ recipe: SingleItemCalculator.OutputRecipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        RecipeLayoutView(
            outputViewModel: RecipeIngredientViewModel(state: RecipeIngredientSingleItemViewModelState(recipe.output)),
            byproductViewModels: recipe.byproducts.map {
                RecipeIngredientViewModel(state: RecipeIngredientSingleItemViewModelState($0))
            },
            inputViewModels: recipe.inputs.map {
                RecipeIngredientViewModel(state: RecipeIngredientSingleItemViewModelState($0))
            }
        )
    }
}

#if DEBUG
import SHModels
import SHStorage
import SHSettings

private struct _SingleItemProductionRecipeDisplayPreview: View {
    let showIngredientNames: Bool
    
    @Dependency(\.storageService)
    private var storageService
    
    @Namespace
    private var namespace
    
    var recipes: [Recipe] {
        [
            storageService.recipe(id: "recipe-iron-ingot"),
            storageService.recipe(id: "recipe-iron-ingot"),
            storageService.recipe(id: "recipe-reinforced-iron-plate"),
            storageService.recipe(id: "recipe-crystal-oscillator"),
            storageService.recipe(id: "recipe-plastic"),
            storageService.recipe(id: "recipe-diluted-fuel"),
            storageService.recipe(id: "recipe-non-fissile-uranium"),
            storageService.recipe(id: "recipe-alternate-heavy-oil-residue")
        ].compactMap { $0 }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(recipes) { recipe in
                    RecipeDisplayView(SingleItemCalculator.OutputRecipe(
                        recipe: recipe,
                        output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                            item: recipe.output.item,
                            amount: recipe.amountPerMinute(for: recipe.output)
                        ),
                        byproducts: recipe.byproducts.map {
                            SingleItemCalculator.OutputRecipe.ByproductIngredient(
                                item: $0.item,
                                amount: recipe.amountPerMinute(for: $0),
                                byproducts: [],
                                isSelected: false
                            )
                        },
                        inputs: recipe.inputs.map {
                            SingleItemCalculator.OutputRecipe.InputIngredient(
                                producingProductID: nil,
                                item: $0.item,
                                amount: recipe.amountPerMinute(for: $0),
                                byproducts: [],
                                isSelected: false
                            )
                        },
                        proportion: .auto
                    ))
                }
            }
            .padding(.horizontal)
        }
        .showIngredientNames(showIngredientNames)
    }
}

#Preview("Recipe Display View (Icon)") {
    _SingleItemProductionRecipeDisplayPreview(showIngredientNames: false)
}

#Preview("Recipe Display View (Row)") {
    _SingleItemProductionRecipeDisplayPreview(showIngredientNames: true)
}
#endif
