import SwiftUI
import SHSettings
import SHModels

struct RecipeDisplayView: View {
    let viewModel: RecipeDisplayViewModel
    
    private let gridItem = GridItem(.adaptive(minimum: 80, maximum: 100), spacing: 12, alignment: .top)
    
    @Environment(\.displayScale)
    private var displayScale
    
    @ScaledMetric(relativeTo: .body)
    private var titleIconSpacing = 8.0
    
    @ScaledMetric(relativeTo: .body)
    private var titleRowSpacing = 16.0
    
    var body: some View {
        let backgroundShape = AngledRectangle(cornerRadius: 8).inset(by: -4)
        
        recipeBody
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background, in: backgroundShape)
            .contentShape(.interaction, Rectangle())
            .contentShape(.contextMenuPreview, backgroundShape)
    }
    
    @MainActor @ViewBuilder
    private var recipeBody: some View {
        VStack(alignment: .leading, spacing: titleIconSpacing) {
            titleView
            
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
        .padding(4)
    }
    
    @MainActor @ViewBuilder
    private var titleView: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(viewModel.recipe.localizedName)
                .fontWeight(.medium)
            
            Spacer()
            
            alternateIndicatorView
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
            .opacity(viewModel.recipe.isDefault ? 0.0 : 1.0)
    }
    
    @MainActor @ViewBuilder
    private var outputView: some View {
        RecipeIngredientView(viewModel: viewModel.outputIngredientViewModel())
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
import SHStorage

private struct _RecipeDisplayViewPreview: View {
    @Dependency(\.storageService)
    private var storageService
    
    @Namespace
    private var namespace
    
    private var recipes: [Recipe] {
        [
            storageService.recipe(id: "recipe-iron-ingot"),
            storageService.recipe(id: "recipe-reinforced-iron-plate"),
            storageService.recipe(id: "recipe-crystal-oscillator"),
            storageService.recipe(id: "recipe-plastic"),
            storageService.recipe(id: "recipe-diluted-fuel"),
            storageService.recipe(id: "recipe-non-fissile-uranium"),
            storageService.recipe(id: "recipe-alternate-heavy-oil-residue"),
            storageService.recipe(id: "recipe-smart-plating")
        ].compactMap { $0 }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(recipes) { recipe in
                    RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: recipe))
                        .contextMenu {
                            Button("Preview") {}
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview("Recipe Display View (Icon)") {
    _RecipeDisplayViewPreview()
        .showIngredientNames(false)
}

#Preview("Recipe Display View (Row)") {
    _RecipeDisplayViewPreview()
        .showIngredientNames(true)
}
#endif
