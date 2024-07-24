import SwiftUI
import SHSettings
import SHModels

struct RecipeDisplayView: View {
    let viewModel: RecipeDisplayViewModel
    
    private let gridItem = GridItem(.adaptive(minimum: 80), spacing: 12, alignment: .top)
    
    @Environment(\.displayScale)
    private var displayScale
    
    @ScaledMetric(relativeTo: .body)
    private var titleIconSpacing = 8.0
    
    @ScaledMetric(relativeTo: .body)
    private var titleRowSpacing = 16.0
    
    @Namespace
    private var namespace
    
    var body: some View {
        recipeBody
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background, in: AngledRectangle(cornerRadius: 8).inset(by: -4))
            .contentShape(.interaction, Rectangle())
            .contentShape(.contextMenuPreview, AngledRectangle(cornerRadius: 8).inset(by: -4))
    }
    
    @MainActor @ViewBuilder
    private var recipeBody: some View {
        VStack(alignment: .leading, spacing: titleIconSpacing) {
            titleView
                .matchedGeometryEffect(id: "recipe-title", in: namespace)
            
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
    }
    
    @MainActor @ViewBuilder
    private var titleView: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(viewModel.recipe.localizedName)
                .fontWeight(.medium)
            
            Spacer()
            
            alternateIndicatorView
            
            pinnedIndicatorView
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
    private var pinnedIndicatorView: some View {
        if viewModel.pinned {
            Image(systemName: "pin.fill")
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
    
    private var recipes: [(Recipe, Bool)] {
        [
            (storageService.recipe(for: "recipe-iron-ingot"), false),
            (storageService.recipe(for: "recipe-reinforced-iron-plate"), false),
            (storageService.recipe(for: "recipe-crystal-oscillator"), false),
            (storageService.recipe(for: "recipe-plastic"), false),
            (storageService.recipe(for: "recipe-diluted-fuel"), false),
            (storageService.recipe(for: "recipe-non-fissile-uranium"), false),
            (storageService.recipe(for: "recipe-alternate-heavy-oil-residue"), false),
            (storageService.recipe(for: "recipe-smart-plating"), true)
        ].compactMap {
            guard let recipe = $0.0 else { return nil }
            
            return (recipe, $0.1)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(recipes, id: \.0.id) { recipe, pinned in
                    RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: recipe, pinned: pinned))
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
