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
                Section("Saved productions") {
                    productionList()
                }
                .listRowSeparator(.hidden)
            }
            
            if !pinnedRecipes.isEmpty {
                Section("Pinned Recipes") {
                    recipesList(pinnedRecipes)
                }
                .listRowSeparator(.hidden)
            }
            
            Section("Recipes") {
                recipesList(sortedRecipes)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .frame(maxWidth: 700)
    }
    
    private func recipesList(_ recipes: [Recipe]) -> some View {
        ForEach(recipes) { recipe in
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .fontWeight(.bold)
                
                switch settings.itemViewStyle {
                case .icon: recipeIconView(recipe: recipe)
                case .row: recipeRowView(recipe: recipe)
                }
                
                HStack(spacing: 0) {
                    Text("Produced in: ")
                    Text(recipe.machines[0].name)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                }
            }
            .listRowSeparator(.hidden)
            .onTapGesture {
                selectedRecipe = recipe
            }
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
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
                .tint(.orange)
            }
            
            if recipe.id != recipes.last?.id {
                Spacer()
                    .frame(height: 10)
                    .listRowSeparator(.hidden)
            }
        }
    }
    
    private func recipeRowView(recipe: Recipe) -> some View {
        RecipeView(recipe: recipe)
            .contentShape(Rectangle())
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .foregroundStyle(.regularMaterial)
                    .foregroundColor(.secondary)
            )
    }
    
    private func recipeIconView(recipe: Recipe) -> some View {
        RecipeView(recipe: recipe)
            .contentShape(Rectangle())
    }
    
    private func productionList() -> some View {
        ForEach(productionChains) { productionChain in
            VStack(alignment: .leading) {
                Text(productionChain.recipe.name)
                    .fontWeight(.semibold)
                
                switch settings.itemViewStyle {
                case .icon: recipeIconView(recipe: productionChain.recipe)
                case .row: recipeRowView(recipe: productionChain.recipe)
                }
                
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
