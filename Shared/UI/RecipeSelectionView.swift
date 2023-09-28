import SwiftUI

struct RecipeSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var storage: Storage
    @EnvironmentObject private var settings: Settings
    
    @State private var isShowingConfirmation = false
    
    var item: Item
    
    @Binding var selectedRecipe: Recipe?
    @Binding var selectedProductionChain: ProductionChain?
    
    var showProductionChains = true
    
    private var productionChains: [ProductionChain] {
        storage[productionChainsFor: item.id]
    }
    
    private var pinnedRecipes: [Recipe] {
        storage[recipesFor: item.id].filter {
            $0.isPinned
        }.sorted { lhs, _ in
            lhs.isDefault
        }
    }
    
    private var sortedRecipes: [Recipe] {
        storage[recipesFor: item.id].filter {
            !$0.isPinned
        }.sorted { lhs, _ in
            lhs.isDefault
        }
    }
    
    var body: some View {
        List {
            if !productionChains.isEmpty && showProductionChains {
                Section {
                    productionList()
                } header: {
                    ListSectionHeader(title: "Saved productions")
                        .foregroundStyle(.primary)
                }
                .listRowSeparator(.hidden)
            }
            
            Section {
                recipesList(pinnedRecipes)
            } header: {
                if !pinnedRecipes.isEmpty {
                    ListSectionHeader(title: "Pinned Recipes")
                        .foregroundStyle(.primary)
                }
            }
            .listRowSeparator(.hidden)
            
            Section {
                recipesList(sortedRecipes)
            } header: {
                if showProductionChains, !productionChains.isEmpty || !pinnedRecipes.isEmpty {
                    ListSectionHeader(title: "Recipes")
                        .foregroundStyle(.primary)
                }
            }
            .listRowSeparator(.hidden)
        }
        .frame(maxWidth: 600)
        .listStyle(.plain)
    }
    
    private func recipesList(_ recipes: [Recipe]) -> some View {
        ForEach(recipes) { recipe in
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .fontWeight(.bold)
                
                RecipeView(recipe: recipe)
                    .contentShape(Rectangle())
            }
            .listRowSeparator(.hidden)
            .onTapGesture {
                selectedRecipe = recipe
            }
            .contextMenu {
                Button {
                    withAnimation {
                        storage[recipeID: recipe.id]?.isPinned.toggle()
                    }
                } label: {
                    Label(
                        recipe.isPinned ? "Unpin" : "Pin",
                        systemImage: recipe.isPinned ? "pin.slash" : "pin"
                    )
                }
            }
        }
    }
    
    private func productionList() -> some View {
        ForEach(productionChains) { productionChain in
            VStack(alignment: .leading) {
                Text(productionChain.recipe.name)
                    .fontWeight(.semibold)
                
                RecipeView(recipe: productionChain.recipe)
                    .contentShape(Rectangle())
                
                HStack(spacing: 12) {
                    Text("Amount: ")
                    Text(productionChain.amount.formatted(.fractionFromZeroToFour))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                }
            }
            .onTapGesture {
                selectedProductionChain = productionChain
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button {
                    storage[productionChainID: productionChain.id] = nil
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .tint(.red)
            }
        }
    }
}

struct RecipeSelectionPreview: PreviewProvider {
    @StateObject static private var storage: Storage = PreviewStorage()
    
    static private var turboMotor: Part {
        storage[partID: "turbo-motor"]!
    }

    static var previews: some View {
        RecipeSelectionView(
            item: turboMotor,
            selectedRecipe: .constant(nil),
            selectedProductionChain: .constant(nil)
        )
            .environmentObject(storage)
            .environmentObject(Settings())
    }
}
