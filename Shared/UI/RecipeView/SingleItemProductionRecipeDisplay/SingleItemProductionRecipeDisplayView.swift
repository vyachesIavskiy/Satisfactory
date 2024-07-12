import SwiftUI

struct SingleItemProductionRecipeDisplayView: View {
    let viewModel: SingleItemProductionRecipeDisplayViewModel
    
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
                let outputViewModel = viewModel.outputIngredientViewModel()
                RecipeIngredientRowView(viewModel: outputViewModel)
                
                ForEach(viewModel.byproductIngredientViewModels()) { viewModel in
                    RecipeIngredientRowView(viewModel: viewModel)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.inputIngredientViewModels()) { viewModel in
                    RecipeIngredientRowView(viewModel: viewModel)
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
        let outputViewModel = viewModel.outputIngredientViewModel()
        RecipeIngredientIconView(viewModel: outputViewModel)
    }
    
    @MainActor @ViewBuilder
    private var byproductsIconView: some View {
        ForEach(Array(viewModel.byproductIngredientViewModels().enumerated()), id: \.element.item.id) { index, viewModel in
            RecipeIngredientIconView(viewModel: viewModel)
        }
    }
    
    @MainActor @ViewBuilder
    private var inputsIconView: some View {
        ForEach(Array(viewModel.inputIngredientViewModels().enumerated()), id: \.element.item.id) { index, viewModel in
            RecipeIngredientIconView(viewModel: viewModel)
        }
    }
}

#if DEBUG
import SHModels
import SHStorage
import SHSettings

private struct _SingleItemProductionRecipeDisplayPreview: View {
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
                    SingleItemProductionRecipeDisplayView(viewModel: viewModel(for: recipe))
                }
            }
            .padding(.horizontal)
        }
        .viewMode(viewMode)
    }
    
    func viewModel(for recipe: Recipe) -> SingleItemProductionRecipeDisplayViewModel {
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
        
        return SingleItemProductionRecipeDisplayViewModel(recipe: recipe)
    }
}

#Preview("Recipe Display View (Icon)") {
    _SingleItemProductionRecipeDisplayPreview(viewMode: .icon)
}

#Preview("Recipe Display View (Row)") {
    _SingleItemProductionRecipeDisplayPreview(viewMode: .row)
}
#endif
