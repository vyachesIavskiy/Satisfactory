import SwiftUI
import SHModels

struct InitialRecipeSelectionView: View {
    @State
    var viewModel: InitialRecipeSelectionViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss
    
    @ScaledMetric(relativeTo: .title)
    private var iconSize = 30.0
    
    @ScaledMetric(relativeTo: .body)
    private var sectionSpacing = 8.0
    
    @ScaledMetric(relativeTo: .body)
    private var recipeSpacing = 16.0
    
    var body: some View {
        List {
            ForEach($viewModel.sections) { $section in
                recipesSection($section)
            }
            .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle(viewModel.item.localizedName)
        .task {
            await viewModel.observeStorage()
        }
    }
    
    @MainActor @ViewBuilder
    private func recipesSection(_ _section: Binding<InitialRecipeSelectionViewModel.Section>) -> some View {
        let section = _section.wrappedValue
        if !section.recipes.isEmpty {
            Section(isExpanded: _section.expanded) {
                ForEach(section.recipes) { recipe in
                    recipeView(recipe)
                }
            } header: {
                if viewModel.sectionHeaderVisible(section) {
                    SHSectionHeader(section.title, expanded: _section.expanded)
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        .padding(.bottom, 4)
                        .background(.background)
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
        .contextMenu {
            if viewModel.pinsAllowed() {
                Button {
                    viewModel.changePinStatus(for: recipe)
                } label: {
                    if viewModel.isPinned(recipe) {
                        Label("Unpin", systemImage: "pin.slash.fill")
                    } else {
                        Label("Pin", systemImage: "pin.fill")
                    }
                }
            }
        }
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
                InitialRecipeSelectionView(viewModel: InitialRecipeSelectionViewModel(item: item))
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
