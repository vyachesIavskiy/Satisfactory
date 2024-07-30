import SwiftUI
import SHModels

struct InitialRecipeSelectionView: View {
    @State
    var viewModel: InitialRecipeSelectionViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss

    @Namespace
    private var namespace
    
    @ScaledMetric(relativeTo: .title)
    private var iconSize = 30.0
    
    @ScaledMetric(relativeTo: .body)
    private var sectionSpacing = 8.0
    
    @ScaledMetric(relativeTo: .body)
    private var recipeSpacing = 16.0
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach($viewModel.sections) { $section in
                    recipesSection($section)
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
        .navigationTitle(viewModel.item.localizedName)
    }
    
    @MainActor @ViewBuilder
    private func recipesSection(_ _section: Binding<InitialRecipeSelectionViewModel.Section>) -> some View {
        let section = _section.wrappedValue
        if !section.recipes.isEmpty {
            LazyVStack(alignment: .leading, spacing: 8, pinnedViews: .sectionHeaders) {
                Section(isExpanded: _section.expanded) {
                    ForEach(Array(section.recipes.enumerated()), id: \.element.id) { index, recipe in
                        VStack {
                            recipeView(recipe)
                            
                            if index != section.recipes.count - 1 {
                                Divider()
                                    .padding(.leading, 16)
                            }
                        }
                        .padding(.vertical, 8)
                        .disabled(!section.expanded)
                    }
                } header: {
                    if viewModel.sectionHeaderVisible(section) {
                        SHSectionHeader(section.title, expanded: _section.expanded)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.background)
                    }
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private func recipeView(_ recipe: Recipe) -> some View {
        Button {
            viewModel.onRecipeSelected?(recipe)
        } label: {
            RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: recipe))
        }
        .buttonStyle(.plain)
        .matchedGeometryEffect(id: recipe.id, in: namespace)
        .contextMenu {
            if viewModel.pinsAllowed() {
                Button {
                    viewModel.changePinStatus(for: recipe)
                } label: {
                    if viewModel.isPinned(recipe) {
                        Text("Unpin")
                    } else {
                        Text("Pin")
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#if DEBUG
import SHStorage

private struct _InitialRecipeSelectionPreview: View {
    let itemID: String
    
    @Dependency(\.storageService)
    private var storageService
    
    private var item: (any Item)? {
        storageService.item(id: itemID)
    }
    
    var body: some View {
        NavigationStack {
            if let item {
                ScrollView {
                    InitialRecipeSelectionView(viewModel: InitialRecipeSelectionViewModel(item: item))
                }
            } else {
                Text("There is no item with ID '\(itemID)'")
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
}

#Preview("Iron Ingot") {
    _InitialRecipeSelectionPreview(itemID: "part-iron-ingot")
}

#Preview("Reinforced Iron Plate") {
    _InitialRecipeSelectionPreview(itemID: "part-reinforced-iron-plate")
}
#endif
