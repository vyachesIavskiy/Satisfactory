import SwiftUI
import SHSingleItemProduction

struct SingleItemProductionRecipeSelectView: View {
    let viewModel: SingleItemProductionRecipeSelectViewModel
    
    private let gridItem = GridItem(.adaptive(minimum: 80, maximum: 100), spacing: 12, alignment: .top)
    
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
        .buttonStyle(.shIngredient)
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
    private func outputViewBuilder<Output: View>(
        output: SHSingleItemProduction.OutputRecipe.OutputIngredient,
        @ViewBuilder _ outputViewBuilder: (RecipeIngredientViewModel) -> Output
    ) -> some View {
        let outputViewModel = RecipeIngredientViewModel(productionOutput: output)
        let outputView = outputViewBuilder(outputViewModel)
        
        outputView
            .grayscale(viewModel.selectedByproduct != nil ? 1.0 : 0.0)
    }
    
    @MainActor @ViewBuilder
    private func byproductViewBuilder<Byproduct: View>(
        byproduct: SHSingleItemProduction.OutputRecipe.ByproductIngredient,
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
            }
        } else {
            byproductView
                .grayscale(viewModel.selectedByproduct != nil ? 1.0 : 0.0)
        }
    }
    
    @MainActor @ViewBuilder
    private func inputViewBuilder<Input: View>(
        input: SHSingleItemProduction.OutputRecipe.InputIngredient,
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
                .menuStyle(.button)
            }
        } else if canSelectRecipe {
            Button {
                viewModel.selectRecipe(for: input)
            } label: {
                inputView
            }
            .disabled(viewModel.selectedByproduct != nil)
        } else {
            inputView
                .grayscale(viewModel.selectedByproduct != nil ? 1.0 : 0.0)
        }
    }
}

struct RecipeIngredientButtonStyle: ButtonStyle {
    @Environment(\.isEnabled)
    private var isEnabled
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .grayscale(isEnabled ? 0.0 : 1.0)
            .background(
                configuration.isPressed ? Color.sh(.gray20) : .clear,
                in: AngledRectangle(cornerRadius: 8)
            )
            .animation(.default, value: configuration.isPressed)
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
        let recipe = SHSingleItemProduction.OutputRecipe(
            recipe: recipe,
            output: SHSingleItemProduction.OutputRecipe.OutputIngredient(
                item: recipe.output.item,
                amount: recipe.amountPerMinute(for: recipe.output)
            ),
            byproducts: recipe.byproducts.map {
                SHSingleItemProduction.OutputRecipe.ByproductIngredient(
                    item: $0.item,
                    amount: recipe.amountPerMinute(for: $0),
                    byproducts: [],
                    isSelected: false
                )
            },
            inputs: recipe.inputs.map {
                SHSingleItemProduction.OutputRecipe.InputIngredient(
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
            product: SHSingleItemProduction.OutputItem(item: recipe.output.item, recipes: [recipe]),
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
