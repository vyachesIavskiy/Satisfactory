import SwiftUI

struct SingleItemProductionRecipeSelectView: View {
    let viewModel: SingleItemProductionRecipeSelectViewModel
    
    private let gridItem = GridItem(.adaptive(minimum: 80), spacing: 12)
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.viewMode)
    private var viewMode
    
    @ScaledMetric(relativeTo: .body)
    private var titleIconSpacing = 8.0
    
    @ScaledMetric(relativeTo: .body)
    private var titleRowSpacing = 16.0
    
    var body: some View {
        ZStack {
            switch viewMode {
            case .icon: iconBody
            case .row: rowBody
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @MainActor @ViewBuilder
    private var iconBody: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .top, spacing: 24) {
                HStack(alignment: .top, spacing: 12) {
                    outputIconView
                    
                    byproductsIconView
                }
                
                HStack(alignment: .top, spacing: 12) {
                    inputsIconView
                }
            }
            
            HStack(alignment: .top, spacing: 24) {
                VStack(spacing: 12) {
                    outputIconView
                    
                    byproductsIconView
                }
                
                LazyVGrid(columns: [gridItem, gridItem], spacing: 12) {
                    inputsIconView
                }
                .fixedSize()
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var rowBody: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                outputView(output: viewModel.recipe.output) { outputViewModel in
                    RecipeIngredientRowView(viewModel: outputViewModel)
                }
                
                ForEach(viewModel.recipe.byproducts) { byproduct in
                    byproductView(byproduct: byproduct) { byproductViewModel in
                        RecipeIngredientRowView(viewModel: byproductViewModel)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.recipe.inputs) { input in
                    inputView(input: input) { inputViewModel in
                        RecipeIngredientRowView(viewModel: inputViewModel)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @MainActor @ViewBuilder
    private var titleView: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(viewModel.recipe.model.localizedName)
                .fontWeight(.medium)
            
            Spacer()
            
            if !viewModel.recipe.model.isDefault {
                alternateIndicatorView
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var alternateIndicatorView: some View {
        Text("Alternate")
            .font(.caption)
            .fontWeight(.light)
            .foregroundStyle(.sh(.midnight))
            .padding(.vertical, 2)
            .padding(.horizontal, 6)
            .background {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(.sh(.midnight10))
                    .stroke(.sh(.midnight40), lineWidth: 1)
            }
            .foregroundStyle(.sh(.midnight100))
    }
    
    @MainActor @ViewBuilder
    private var outputIconView: some View {
        outputView(output: viewModel.recipe.output) { outputViewModel in
            RecipeIngredientIconView(viewModel: outputViewModel)
        }
    }
    
    @MainActor @ViewBuilder
    private var byproductsIconView: some View {
        ForEach(viewModel.recipe.byproducts) { byproduct in
            byproductView(byproduct: byproduct) { byproductViewModel in
                RecipeIngredientIconView(viewModel: byproductViewModel)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var inputsIconView: some View {
        ForEach(viewModel.recipe.inputs) { input in
            inputView(input: input) { inputViewModel in
                RecipeIngredientIconView(viewModel: inputViewModel)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private func outputView<Output: View>(
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
                        // TODO: Check byproduct selection step
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
    private func byproductView<Byproduct: View>(
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
                        // TODO: Check byproduct selection step
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
    private func inputView<Input: View>(
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
    let viewMode: ViewMode
    
    @Dependency(\.storageService.recipes)
    private var storedRecipes
    
    @Namespace
    private var namespace
    
    var recipes: [Recipe] {
        [
            storedRecipes().first(id: "recipe-iron-ingot"),
            storedRecipes().first(id: "recipe-reinforced-iron-plate"),
            storedRecipes().first(id: "recipe-crystal-oscillator"),
            storedRecipes().first(id: "recipe-plastic"),
            storedRecipes().first(id: "recipe-diluted-fuel"),
            storedRecipes().first(id: "recipe-non-fissile-uranium"),
            storedRecipes().first(id: "recipe-alternate-heavy-oil-residue")
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
        .viewMode(viewMode)
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
    _SingleItemProductionRecipeSelectPreview(viewMode: .icon)
}

#Preview("Recipe Display View (Row)") {
    _SingleItemProductionRecipeSelectPreview(viewMode: .row)
}
#endif