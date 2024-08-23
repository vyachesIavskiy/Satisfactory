import SwiftUI
import SingleItemCalculator

struct SingleItemProductionRecipeSelectView: View {
    let viewModel: SingleItemProductionRecipeSelectViewModel
    
    private let gridItem = GridItem(.adaptive(minimum: 80, maximum: 100), spacing: 12, alignment: .top)
    
    @Environment(\.displayScale)
    private var displayScale
    
    var body: some View {
        recipeBody
            .frame(maxWidth: .infinity, alignment: .leading)
            .animation(.default, value: viewModel.selectedByproduct == nil)
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
                        .frame(maxHeight: .infinity)
                }
                .fixedSize()
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var outputView: some View {
        let outputViewModel = RecipeIngredientViewModel(productionOutput: viewModel.recipe.output)
        
        RecipeIngredientView(viewModel: outputViewModel)
            .disabledStyle(viewModel.selectedByproduct != nil)
    }
    
    @MainActor @ViewBuilder
    private var byproductsView: some View {
        ForEach(viewModel.recipe.byproducts) { byproduct in
            byproductViewBuilder(byproduct: byproduct) { byproductViewModel in
                RecipeIngredientView(viewModel: byproductViewModel)
            }
            .buttonStyle(.shIngredient)
        }
    }
    
    @MainActor @ViewBuilder
    private var inputsView: some View {
        ForEach(viewModel.recipe.inputs) { input in
            inputViewBuilder(input: input) { inputViewModel in
                RecipeIngredientView(viewModel: inputViewModel)
            }
            .buttonStyle(.shIngredient)
        }
    }
    
    @MainActor @ViewBuilder
    private func byproductViewBuilder<Byproduct: View>(
        byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient,
        @ViewBuilder _ byproductViewBuilder: (RecipeIngredientViewModel) -> Byproduct
    ) -> some View {
        let byproductViewModel = RecipeIngredientViewModel(productionByproduct: byproduct)
        let byproductView = byproductViewBuilder(byproductViewModel)
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
                    Button("Stop providing byproduct") {
                        viewModel.unselectByproductProducer(for: byproduct)
                    }
                }
                
                if canSelectByproduct {
                    Button("Provide byproduct...") {
                        viewModel.selectByproductProducer(for: byproduct)
                    }
                }
            } label: {
                byproductView
            }
        } else {
            byproductView
                .disabledStyle(viewModel.selectedByproduct != nil)
        }
    }
    
    @MainActor @ViewBuilder
    private func inputViewBuilder<Input: View>(
        input: SingleItemCalculator.OutputRecipe.InputIngredient,
        @ViewBuilder _ inputViewBuilder: (RecipeIngredientViewModel) -> Input
    ) -> some View {
        let inputViewModel = RecipeIngredientViewModel(productionInput: input)
        let inputView = inputViewBuilder(inputViewModel)
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
                    Button("Select recipe") {
                        viewModel.selectRecipe(for: input)
                    }
                }
                
                Divider()
                
                if canUnselectByproduct {
                    Button("Stop consuming byproduct") {
                        viewModel.unselectByproductConsumer(for: input)
                    }
                }
                
                if canSelectByproduct {
                    Button("Consume byproduct...") {
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
            .disabledStyle(viewModel.selectedByproduct != nil)
        } else {
            inputView
                .disabledStyle(viewModel.selectedByproduct != nil)
        }
    }
}

private extension View {
    @MainActor @ViewBuilder
    func disabledStyle(_ disabled: Bool) -> some View {
        grayscale(disabled ? 0.5 : 0.0)
            .brightness(disabled ? -0.25 : 0.0)
    }
}

struct RecipeIngredientButtonStyle: ButtonStyle {
    @Environment(\.isEnabled)
    private var isEnabled
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .disabledStyle(!isEnabled)
            .background(
                configuration.isPressed ? Color.sh(.gray20) : .clear,
                in: AngledRectangle(cornerRadius: 8)
            )
    }
}

extension ButtonStyle where Self == RecipeIngredientButtonStyle {
    static var shIngredient: Self { RecipeIngredientButtonStyle() }
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
                    SingleItemProductionRecipeSelectView(viewModel: viewModel(for: recipe))
                }
            }
            .padding(.horizontal)
        }
        .showIngredientNames(showIngredientNames)
    }
    
    func viewModel(for recipe: Recipe) -> SingleItemProductionRecipeSelectViewModel {
        let recipe = SingleItemCalculator.OutputRecipe(
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
        )
        
        return SingleItemProductionRecipeSelectViewModel(
            product: SingleItemCalculator.OutputItem(item: recipe.output.item, recipes: [recipe]),
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
