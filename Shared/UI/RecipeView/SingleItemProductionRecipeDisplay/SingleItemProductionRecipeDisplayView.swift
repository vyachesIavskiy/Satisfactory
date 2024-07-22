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
        let outputViewModel = viewModel.outputIngredientViewModel()
        RecipeIngredientView(viewModel: outputViewModel)
    }
    
    @MainActor @ViewBuilder
    private var byproductsView: some View {
        ForEach(Array(viewModel.byproductIngredientViewModels().enumerated()), id: \.element.item.id) { index, viewModel in
            RecipeIngredientView(viewModel: viewModel)
        }
    }
    
    @MainActor @ViewBuilder
    private var inputsView: some View {
        ForEach(Array(viewModel.inputIngredientViewModels().enumerated()), id: \.element.item.id) { index, viewModel in
            RecipeIngredientView(viewModel: viewModel)
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
