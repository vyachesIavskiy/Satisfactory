import SwiftUI
import SHSharedUI
import SHSingleItemCalculator

struct CalculatorRecipeView: View {
    let viewModel: CalculatorRecipeViewModel
    
    private let gridItem = GridItem(.adaptive(minimum: 80, maximum: 100), spacing: 12, alignment: .top)
    
    @Environment(\.displayScale)
    private var displayScale
    
    var body: some View {
        RecipeLayoutView(
            outputViewModel: viewModel.outputViewModel,
            byproductViewModels: viewModel.byproductViewModels,
            inputViewModels: viewModel.inputViewModels
        ) {
            $0.disabledStyle(viewModel.byproductSelectionState != nil)
        } byproduct: { index, ingredientView in
            let byproduct = viewModel.outputRecipe.byproducts[index]
            byproductViewBuilder(byproduct: byproduct) {
                ingredientView
            }
            .buttonStyle(.shIngredient(byproduct.part))
        } input: { index, ingredientView in
            let input = viewModel.outputRecipe.inputs[index]
            inputViewBuilder(input: input) {
                ingredientView
            }
            .buttonStyle(.shIngredient(input.part))
        }
    }
    
    @MainActor @ViewBuilder
    private func byproductViewBuilder<Byproduct: View>(
        byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient,
        @ViewBuilder _ byproductViewBuilder: () -> Byproduct
    ) -> some View {
        let byproductView = byproductViewBuilder()
        let canSelectByproduct = viewModel.canSelectByproductProducer(for: byproduct)
        let canUnselectByproduct = viewModel.canUnselectByproductProducer(for: byproduct)
        let canConfirmByproduct = viewModel.canConfirmByproduct(byproduct)
        
        if canConfirmByproduct {
            Button {
                viewModel.selectByproductProducer(for: byproduct)
            } label: {
                byproductView
            }
        } else if canSelectByproduct || canUnselectByproduct {
            Menu {
                if canUnselectByproduct {
                    Button("single-item-production-ingredient-stop-providing-byproduct") {
                        viewModel.unselectByproductProducer(for: byproduct)
                    }
                }
                
                if canSelectByproduct {
                    Button("single-item-production-ingredient-provide-byproduct") {
                        viewModel.selectByproductProducer(for: byproduct)
                    }
                }
            } label: {
                byproductView
            }
        } else {
            byproductView
                .disabledStyle(viewModel.byproductSelectionState != nil)
        }
    }
    
    @MainActor @ViewBuilder
    private func inputViewBuilder<Input: View>(
        input: SingleItemCalculator.OutputRecipe.InputIngredient,
        @ViewBuilder _ inputViewBuilder: () -> Input
    ) -> some View {
        let inputView = inputViewBuilder()
        let canSelectRecipe = viewModel.canSelectRecipe(for: input)
        let canSelectByproduct = viewModel.canSelectByproductConsumer(for: input)
        let canUnselectByproduct = viewModel.canUnselectByproductConsumer(for: input)
        let canConfirmByproduct = viewModel.canConfirmByproduct(input)
        
        if canConfirmByproduct {
            Button {
                viewModel.selectByproductConsumer(for: input)
            } label: {
                inputView
            }
        } else if canSelectByproduct || canUnselectByproduct {
            Menu {
                if canSelectRecipe {
                    Button("single-item-production-ingredient-select-recipe") {
                        viewModel.selectRecipe(for: input)
                    }
                }
                
                Divider()
                
                if canUnselectByproduct {
                    Button("single-item-production-ingredient-stop-consuming-byproduct") {
                        viewModel.unselectByproductConsumer(for: input)
                    }
                }
                
                if canSelectByproduct {
                    Button("single-item-production-ingredient-consume-byproduct") {
                        viewModel.selectByproductConsumer(for: input)
                    }
                }
            } label: {
                inputView
            }
            .menuStyle(.button)
        } else if canSelectRecipe {
            Button {
                viewModel.selectRecipe(for: input)
            } label: {
                inputView
            }
            .disabledStyle(viewModel.byproductSelectionState != nil)
        } else {
            inputView
                .disabledStyle(viewModel.byproductSelectionState != nil)
        }
    }
}

#if DEBUG
import SHModels
import SHStorage
import SHSettings

private struct _SingleItemProductionRecipeSelectPreview: View {
    let showIngredientNames: Bool
    
    @Dependency(\.storageService)
    private var storageService
    
    @Namespace
    private var namespace
    
    var recipes: [Recipe] {
        [
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
                    CalculatorRecipeView(viewModel: viewModel(for: recipe))
                }
            }
            .padding(.horizontal)
        }
        .showIngredientNames(showIngredientNames)
    }
    
    func viewModel(for recipe: Recipe) -> CalculatorRecipeViewModel {
        let recipe = SingleItemCalculator.OutputRecipe(
            recipe: recipe,
            output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                part: recipe.output.part,
                amount: recipe.amountPerMinute(for: recipe.output)
            ),
            byproducts: recipe.byproducts.map {
                SingleItemCalculator.OutputRecipe.ByproductIngredient(
                    part: $0.part,
                    amount: recipe.amountPerMinute(for: $0),
                    byproducts: [],
                    isSelected: false
                )
            },
            inputs: recipe.inputs.map {
                SingleItemCalculator.OutputRecipe.InputIngredient(
                    producingProductID: nil,
                    part: $0.part,
                    amount: recipe.amountPerMinute(for: $0),
                    byproducts: [],
                    isSelected: false
                )
            },
            proportion: .auto
        )
        
        return CalculatorRecipeViewModel(
            outputRecipe: recipe,
            byproductSelectionState: nil,
            canPerformAction: { _ in true },
            performAction: { _ in }
        )
    }
}

#Preview("Recipe Display View (Icon)") {
    _SingleItemProductionRecipeSelectPreview(showIngredientNames: false)
}

#Preview("Recipe Display View (Row)") {
    _SingleItemProductionRecipeSelectPreview(showIngredientNames: true)
}
#endif
