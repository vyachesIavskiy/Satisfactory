import SwiftUI
import SHSettings
import SHModels

struct RecipeDisplayView: View {
    let viewModel: RecipeDisplayViewModel
    
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
        .background(.background, in: AngledRectangle(cornerRadius: 8).inset(by: -4))
        .contentShape(.interaction, Rectangle())
        .contentShape(.contextMenuPreview, AngledRectangle(cornerRadius: 8).inset(by: -4))
    }
    
    @MainActor @ViewBuilder
    private var iconBody: some View {
        VStack(alignment: .leading, spacing: titleIconSpacing) {
            HStack(alignment: .firstTextBaseline) {
                Text(viewModel.recipe.localizedName)
                    .fontWeight(.medium)
                
                Spacer()
                
                if !viewModel.recipe.isDefault {
                    alternateIndicatorView
                }
            }
            
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
    }
    
    @MainActor @ViewBuilder
    private var rowBody: some View {
        VStack(alignment: .leading, spacing: titleRowSpacing) {
            VStack(spacing: 4) {
                HStack(alignment: .firstTextBaseline) {
                    Text(viewModel.recipe.localizedName)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    if !viewModel.recipe.isDefault {
                        alternateIndicatorView
                    }
                }
                
                Capsule()
                    .fill(.sh(.midnight))
                    .frame(height: 1)
            }
            
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
    }
    
    @MainActor @ViewBuilder
    private var titleView: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(viewModel.recipe.localizedName)
                .fontWeight(.medium)
            
            Spacer()
            
            if !viewModel.recipe.isDefault {
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
//        let canSelectByproduct = viewModel.canSelectByproduct(
//            for: outputViewModel.item,
//            role: .output
//        )
//        let disabled = viewModel.disabled(item: outputViewModel.item, role: .output)
//
//        if canSelectByproduct {
//            Menu {
//                Button("Consume as byproduct") {
//                    viewModel.onSelectByproduct(item: outputViewModel.item, role: .output)
//                }
//            } label: {
//                RecipeIngredientIconView(viewModel: outputViewModel)
//            }
//            .buttonStyle(.plain)
//            .disabled(disabled)
//        } else {
        RecipeIngredientIconView(viewModel: outputViewModel)
//            .grayscale(disabled ? 1.0 : 0.0)
//    }
    }
    
    @MainActor @ViewBuilder
    private var byproductsIconView: some View {
        ForEach(Array(viewModel.byproductIngredientViewModels().enumerated()), id: \.element.item.id) { index, viewModel in
//            let canSelectByproduct = viewModel.canSelectByproduct(
//                for: byproductViewModel.item,
//                role: .byproduct
//            )
//            let disabled = viewModel.disabled(item: byproductViewModel.item, role: .byproduct)
//
//            if canSelectByproduct {
//                Menu {
//                    Button("Consume as input") {
//                        viewModel.onSelectByproduct(item: byproductViewModel.item, role: .byproduct)
//                    }
//                } label: {
//                    RecipeIngredientIconView(viewModel: byproductViewModel)
//                }
//                .buttonStyle(.plain)
//                .disabled(disabled)
//            } else {
            RecipeIngredientIconView(viewModel: viewModel)
//                .grayscale(disabled ? 1.0 : 0.0)
//        }
        }
    }
    
    @MainActor @ViewBuilder
    private var inputsIconView: some View {
        ForEach(Array(viewModel.inputIngredientViewModels().enumerated()), id: \.element.item.id) { index, viewModel in
//            let canSelectByproduct = viewModel.canSelectByproduct(
//                for: byproductViewModel.item,
//                role: .byproduct
//            )
//            let disabled = viewModel.disabled(item: byproductViewModel.item, role: .byproduct)
//
//            if canSelectByproduct {
//                Menu {
//                    Button("Consume as input") {
//                        viewModel.onSelectByproduct(item: byproductViewModel.item, role: .byproduct)
//                    }
//                } label: {
//                    RecipeIngredientIconView(viewModel: byproductViewModel)
//                }
//                .buttonStyle(.plain)
//                .disabled(disabled)
//            } else {
            RecipeIngredientIconView(viewModel: viewModel)
//                .grayscale(disabled ? 1.0 : 0.0)
//        }
        }
    }
}

#if DEBUG
import SHStorage

private struct _RecipeDisplayViewPreview: View {
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
                    RecipeDisplayView(viewModel: viewModel(for: recipe)/*, namespace: namespace*/)
                        .contextMenu {
                            Button("Preview") {}
                        }
                }
            }
            .padding(.horizontal)
        }
    }
    
    func viewModel(for recipe: Recipe) -> RecipeDisplayViewModel {
        withDependencies {
            $0.settingsService.currentSettings = {
                Settings(viewMode: viewMode)
            }
            $0.settingsService.settings = {
                AsyncStream { Settings(viewMode: viewMode) }
            }
        } operation: {
            RecipeDisplayViewModel(recipe: recipe)
        }
    }
}

#Preview("Recipe Display View (Icon)") {
    _RecipeDisplayViewPreview(viewMode: .icon)
}

#Preview("Recipe Display View (Row)") {
    _RecipeDisplayViewPreview(viewMode: .row)
}
#endif
