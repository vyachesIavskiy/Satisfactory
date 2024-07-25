import SwiftUI
import SHStorage
import SHModels

struct SingleItemProductionInitialRecipeSelectionView: View {
    @State
    var viewModel: SingleItemProductionInitialRecipeSelectionViewModel
    
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
    
    var body: some View {
        ForEach($viewModel.sections) { $section in
            recipesSection($section)
        }
    }
    
    @MainActor
    @ViewBuilder
    private func recipesSection(_ _section: Binding<SingleItemProductionInitialRecipeSelectionViewModel.Section>) -> some View {
        let section = _section.wrappedValue
        if !section.recipes.isEmpty {
            Section(isExpanded: _section.expanded) {
                ForEach(section.recipes) { recipe in
                    recipeView(recipe)
                        .disabled(!section.expanded)
                }
            } header: {
                if viewModel.sectionHeaderVisible(section) {
                    SHSectionHeader(section.title, expanded: _section.expanded)
                }
            }
            .listSectionSeparator(.hidden)
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
            storageService.item(withID: itemID)
            
        // Equipment
        case .portableMiner:
            storageService.item(withID: itemID)
        }
    }
}

private struct _ItemRecipesPreview: View {
    var itemPreview: ItemPreview
    
    var body: some View {
        NavigationStack {
            if let item = itemPreview.item {
                List {
                    SingleItemProductionInitialRecipeSelectionView(viewModel: SingleItemProductionInitialRecipeSelectionViewModel(item: item, onRecipeSelected: { _ in }))
                }
                .listStyle(.plain)
            } else {
                Text("There is no item with ID '\(itemPreview.itemID)'")
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
}

#Preview("Iron Ingot") {
    _ItemRecipesPreview(itemPreview: .ironIngot)
}

#Preview("Reinforced Iron Plate") {
    _ItemRecipesPreview(itemPreview: .reinforcedIronPlate)
}

#Preview("Water") {
    _ItemRecipesPreview(itemPreview: .water)
}

#Preview("Steel Pipe") {
    _ItemRecipesPreview(itemPreview: .steelPipe)
}

#Preview("Portable Miner") {
    _ItemRecipesPreview(itemPreview: .portableMiner)
}
#endif
