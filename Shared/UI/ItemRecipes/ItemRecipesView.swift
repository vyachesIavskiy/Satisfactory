import SwiftUI
import SHStorage
import SHModels

struct ItemRecipesView: View {
    @Bindable 
    var viewModel: ItemRecipesViewModel
    
    @Environment(\.displayScale)
    private var displayScale

    @Namespace
    private var namespace
    
    @ScaledMetric(relativeTo: .title)
    private var iconSize = 30.0
    
    @ScaledMetric(relativeTo: .body)
    private var sectionSpacing = 8.0
    
    @ScaledMetric(relativeTo: .body)
    private var recipeSpacing = 16.0
    
    @State
    private var scrollOffset = CGPoint.zero
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach($viewModel.sections) { $section in
                    recipesSection($section)
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize, axes: .vertical)
        .task {
            try? await viewModel.task()
        }
    }
    
    @MainActor
    @ViewBuilder
    private func recipesSection(_ _section: Binding<ItemRecipesViewModel.Section>) -> some View {
        let section = _section.wrappedValue
        if !section.recipes.isEmpty {
            Section(isExpanded: _section.expanded) {
                VStack(spacing: recipeSpacing) {
                    ForEach(section.recipes) { recipe in
                        recipeView(recipe)
                            .disabled(!section.expanded)
                    }
                }
                .padding(.bottom, section.expanded ? 16 : 0)
            } header: {
                if viewModel.sectionHeaderVisible(section) {
                    SHSectionHeader(section.title, expanded: _section.expanded)
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    @MainActor
    @ViewBuilder
    private func recipeView(_ recipe: Recipe) -> some View {
        Button {
            viewModel.onRecipeSelected(recipe)
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
    }
    
    @MainActor
    @ViewBuilder
    private var alternateIndicatorView: some View {
        Text("Alternate")
            .font(.footnote)
            .fontWeight(.light)
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
            .overlay {
                AngledRectangle(cornerRadius: 2)
                    .stroke(lineWidth: 2 / displayScale)
            }
            .foregroundStyle(Color("Primary"))
    }
}

#if DEBUG
private enum ItemPreview {
    case ironIngot
    case reinforcedIronPlate
    case water
    case steelPipe
    case portableMiner
    
    var itemID: String {
        switch self {
        case .ironIngot: "part-iron-ingot"
        case .reinforcedIronPlate: "part-reinforced-iron-plate"
        case .water: "part-water"
        case .steelPipe: "part-steel-pipe"
        case .portableMiner: "equipment-portable-miner"
        }
    }
    
    var item: (any Item)? {
        @Dependency(\.storageService)
        var storageService
        
        return switch self {
        // Parts
        case .ironIngot, .reinforcedIronPlate, .water, .steelPipe:
            storageService.parts().first(id: itemID)
            
        // Equipment
        case .portableMiner:
            storageService.equipment().first(id: itemID)
        }
    }
}

private struct _ItemRecipesPreview: View {
    var itemPreview: ItemPreview
    
    var body: some View {
        if let item = itemPreview.item {
            ItemRecipesView(viewModel: ItemRecipesViewModel(item: item, onRecipeSelected: { _ in }))
        } else {
            Text("There is no item with ID '\(itemPreview.itemID)'")
                .font(.largeTitle)
                .padding()
        }
    }
}

#Preview("Iron Ingot") {
    NavigationStack {
        _ItemRecipesPreview(itemPreview: .ironIngot)
    }
}

#Preview("Reinforced Iron Plate") {
    NavigationStack {
        _ItemRecipesPreview(itemPreview: .reinforcedIronPlate)
    }
}

#Preview("Water") {
    NavigationStack {
        _ItemRecipesPreview(itemPreview: .water)
    }
}

#Preview("Steel Pipe") {
    NavigationStack {
        _ItemRecipesPreview(itemPreview: .steelPipe)
    }
}

#Preview("Portable Miner") {
    NavigationStack {
        _ItemRecipesPreview(itemPreview: .portableMiner)
    }
}
#endif
