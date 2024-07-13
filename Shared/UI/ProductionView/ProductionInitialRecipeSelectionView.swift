import SHModels
import SHStorage
import SwiftUI

@Observable
final class ProductionInitialRecipeSelectionViewModel {
    let item: any Item
    private let recipes: [Recipe]
    
    @ObservationIgnored
    let onRecipeSelected: @MainActor (Recipe) -> Void
    
    @ObservationIgnored
    @Dependency(\.storageService)
    private var storageService
    
    var pinnedExpanded = true
    var unpinnedExpanded = true
    
    var pinnedRecipes: [Recipe] {
        recipes
            .filter(isPinned)
            .sortedByDefault()
    }
    
    var unpinnedRecipes: [Recipe] {
        recipes
            .filter { !isPinned($0) }
            .sortedByDefault()
    }
    
    var pinsAllowed: Bool {
        recipes.count > 1
    }
    
    init(item: any Item, onRecipeSelected: @escaping @MainActor (Recipe) -> Void) {
        self.item = item
        self.onRecipeSelected = onRecipeSelected
        
        @Dependency(\.storageService)
        var storageService
        
        recipes = storageService.recipes(for: item, as: .output, .byproduct)
    }
    
    func isPinned(_ recipe: Recipe) -> Bool {
        storageService.isRecipePinned(recipe)
    }
    
    @MainActor
    func changePinStatus(for recipe: Recipe) {
        storageService.changeRecipePinStatus(recipe)
    }
}

struct ProductionInitialRecipeSelectionView: View {
    @Bindable
    var viewModel: ProductionInitialRecipeSelectionViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                pinnedSection
                
                unpinnedSection
            }
            .padding(.horizontal, 16)
        }
    }
    
    @MainActor
    @ViewBuilder
    private var pinnedSection: some View {
        if !viewModel.pinnedRecipes.isEmpty {
            Section("Pinned recipes") {
                ForEach(viewModel.pinnedRecipes) { recipe in
                    recipeRow(recipe)
                }
            }
        }
    }
    
    @MainActor
    @ViewBuilder
    private var unpinnedSection: some View {
        if !viewModel.unpinnedRecipes.isEmpty {
            Section {
                if viewModel.unpinnedExpanded {
                    ForEach(viewModel.unpinnedRecipes) { recipe in
                        recipeRow(recipe)
                    }
                }
            } header: {
                SHSectionHeader("Recipes", expanded: $viewModel.unpinnedExpanded)
            }
        }
    }
    
    @MainActor
    @ViewBuilder
    private func recipeRow(_ recipe: Recipe) -> some View {
        Button {
            viewModel.onRecipeSelected(recipe)
        } label: {
            RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: recipe))
        }
        .buttonStyle(.plain)
        .contextMenu {
            if viewModel.pinsAllowed {
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
}

#if DEBUG
private struct _ProductionInitialRecipeSelectionPreview: View {
    let itemID: String
    
    private var item: any Item {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.item(for: itemID)!
    }
    
    var body: some View {
        ProductionInitialRecipeSelectionView(
            viewModel: ProductionInitialRecipeSelectionViewModel(
                item: item,
                onRecipeSelected: { _ in }
            )
        )
    }
}

#Preview {
    _ProductionInitialRecipeSelectionPreview(itemID: "part-reinforced-iron-plate")
}
#endif
