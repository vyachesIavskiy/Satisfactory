import SwiftUI

struct SingleItemProductionRecipeSelectView: View {
    let viewModel: SingleItemProductionRecipeSelectViewModel
    
    private let gridItem = GridItem(.adaptive(minimum: 80), spacing: 12, alignment: .top)
    
    @Environment(\.displayScale)
    private var displayScale
    
    @ScaledMetric(relativeTo: .body)
    private var titleIconSpacing = 8.0
    
    @ScaledMetric(relativeTo: .body)
    private var titleRowSpacing = 16.0
    
    var body: some View {
        recipeBody
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @MainActor @ViewBuilder
    private var recipeBody: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .top, spacing: 24) {
                HStack(alignment: .top, spacing: 12) {
                    outputView
                    
                    byproductsView
                }
                
                HStack(alignment: .top, spacing: 12) {
                    inputsView
                }
            }
            
            HStack(alignment: .top, spacing: 24) {
                VStack(spacing: 12) {
                    outputView
                    
                    byproductsView
                }
                
                LazyVGrid(columns: [gridItem, gridItem], spacing: 12) {
                    inputsView
                }
                .fixedSize()
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var outputView: some View {
        outputViewBuilder(output: viewModel.recipe.output) { outputViewModel in
            RecipeIngredientView(viewModel: outputViewModel)
        }
    }
    
    @MainActor @ViewBuilder
    private var byproductsView: some View {
        ForEach(viewModel.recipe.byproducts) { byproduct in
            byproductViewBuilder(byproduct: byproduct) { byproductViewModel in
                RecipeIngredientView(viewModel: byproductViewModel)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var inputsView: some View {
        ForEach(viewModel.recipe.inputs) { input in
            inputViewBuilder(input: input) { inputViewModel in
                RecipeIngredientView(viewModel: inputViewModel)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private func outputViewBuilder<Output: View>(
        output: SingleItemProduction.Output.Recipe.OutputIngredient,
        @ViewBuilder _ outputViewBuilder: (RecipeIngredientViewModel) -> Output
    ) -> some View {
        let outputViewModel = RecipeIngredientViewModel(productionOutput: output)
        let outputView = outputViewBuilder(outputViewModel)
        let canSelectByproduct = viewModel.canSelectByproductProducer(for: output)
        let canConfirmByproduct = viewModel.canConfirmByproduct(output)
        
        if canSelectByproduct {
            if canConfirmByproduct {
                Button {
                    viewModel.selectByproductProducer(for: output)
                } label: {
                    outputView
                }
                .disabled(viewModel.ingredientDisabled(output))
            } else {
                Menu {
                    Button {
                        viewModel.selectByproductProducer(for: output)
                    } label: {
                        Text("Select as byproduct producer")
                    }
                } label: {
                    outputView
                }
                .disabled(viewModel.ingredientDisabled(output))
            }
        } else {
            outputView
                .grayscale(viewModel.ingredientDisabled(output) ? 1.0 : 0.0)
        }
    }
    
    @MainActor @ViewBuilder
    private func byproductViewBuilder<Byproduct: View>(
        byproduct: SingleItemProduction.Output.Recipe.OutputIngredient,
        @ViewBuilder _ byproductViewBuilder: (RecipeIngredientViewModel) -> Byproduct
    ) -> some View {
        let byproductViewModel = RecipeIngredientViewModel(productionByproduct: byproduct)
        let byproductView = byproductViewBuilder(byproductViewModel)
        let canSelectByproduct = viewModel.canSelectByproductProducer(for: byproduct)
        let canConfirmByproduct = viewModel.canConfirmByproduct(byproduct)
        
        if canSelectByproduct {
            if canConfirmByproduct {
                Button {
                    viewModel.selectByproductProducer(for: byproduct)
                } label: {
                    byproductView
                }
                .disabled(viewModel.ingredientDisabled(byproduct))
            } else {
                Menu {
                    Button {
                        viewModel.selectByproductProducer(for: byproduct)
                    } label: {
                        Text("Select as byproduct producer")
                    }
                } label: {
                    byproductView
                }
                .disabled(viewModel.ingredientDisabled(byproduct))
            }
        } else {
            byproductView
                .grayscale(viewModel.ingredientDisabled(byproduct) ? 1.0 : 0.0)
        }
    }
    
    @MainActor @ViewBuilder
    private func inputViewBuilder<Input: View>(
        input: SingleItemProduction.Output.Recipe.InputIngredient,
        @ViewBuilder _ inputViewBuilder: (RecipeIngredientViewModel) -> Input
    ) -> some View {
        let inputViewModel = RecipeIngredientViewModel(productionInput: input)
        let inputView = inputViewBuilder(inputViewModel)
        let canSelectRecipe = viewModel.canSelectRecipe(for: input)
        let canSelectByproduct = viewModel.canSelectByproductConsumer(for: input)
        let canConfirmByproduct = viewModel.canConfirmByproduct(input)
        
        if canSelectByproduct {
            if canConfirmByproduct {
                Button {
                    viewModel.selectByproductConsumer(for: input)
                } label: {
                    inputView
                }
                .disabled(viewModel.ingredientDisabled(input))
            } else {
                Menu {
                    if canSelectRecipe {
                        Button("Select recipe") {
                            viewModel.selectRecipe(for: input)
                        }
                    }
                    
                    Button("Select as byproduct consumer") {
                        viewModel.selectByproductConsumer(for: input)
                    }
                } label: {
                    inputView
                }
                .disabled(viewModel.ingredientDisabled(input))
            }
        } else if canSelectRecipe {
            Button {
                viewModel.selectRecipe(for: input)
            } label: {
                inputView
            }
            .disabled(viewModel.ingredientDisabled(input))
        } else {
            inputView
                .grayscale(viewModel.ingredientDisabled(input) ? 1.0 : 0.0)
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
            storageService.recipe(for: "recipe-iron-ingot"),
            storageService.recipe(for: "recipe-reinforced-iron-plate"),
            storageService.recipe(for: "recipe-crystal-oscillator"),
            storageService.recipe(for: "recipe-plastic"),
            storageService.recipe(for: "recipe-diluted-fuel"),
            storageService.recipe(for: "recipe-non-fissile-uranium"),
            storageService.recipe(for: "recipe-alternate-heavy-oil-residue")
        ].compactMap { $0 }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(recipes) { recipe in
                    SingleItemProductionRecipeSelectView(viewModel: viewModel(for: recipe))
                }
            }
            .padding(.horizontal)
        }
        .showIngredientNames(showIngredientNames)
    }
    
    func viewModel(for recipe: Recipe) -> SingleItemProductionRecipeSelectViewModel {
        let recipe = SingleItemProduction.Output.Recipe(
            model: recipe,
            output: SingleItemProduction.Output.Recipe.OutputIngredient(
                item: recipe.output.item,
                amount: recipe.amountPerMinute(for: recipe.output),
                byproducts: [],
                isSelected: false
            ),
            byproducts: recipe.byproducts.map {
                SingleItemProduction.Output.Recipe.OutputIngredient(
                    item: $0.item,
                    amount: recipe.amountPerMinute(for: $0),
                    byproducts: [],
                    isSelected: false
                )
            },
            inputs: recipe.input.map {
                SingleItemProduction.Output.Recipe.InputIngredient(
                    producingProductID: nil,
                    item: $0.item,
                    amount: recipe.amountPerMinute(for: $0),
                    byproducts: [],
                    isSelected: false
                )
            },
            proportion: .auto
        )
        
        return SingleItemProductionRecipeSelectViewModel(
            product: SingleItemProduction.Output.Product(item: recipe.output.item, recipes: [recipe]),
            recipe: recipe,
            selectedByproduct: nil,
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
