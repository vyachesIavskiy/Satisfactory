import SwiftUI

struct RecipeSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var storage: Storage
    @EnvironmentObject private var settings: Settings
    
    @State private var isShowingConfirmation = false
    @State private var isProductionExpanded = true
    @State private var isPinnedRecipesExpanded = true
    @State private var isRecipesExpanded = true
    
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
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 18) {
                if !productionChains.isEmpty, showProductionChains {
                    Section {
                        if isProductionExpanded {
                            productionList()
                            
                            ListSectionFooterShape(cornerRadius: 10)
                                .stroke(lineWidth: 0.75)
                                .foregroundStyle(Color("Secondary").opacity(0.75))
                                .shadow(color: Color("Secondary").opacity(0.5), radius: 2)
                        }
                    } header: {
                        ListSectionHeaderNew(title: "Saved productions", isExpanded: $isProductionExpanded)
                    }
                    .listRowSeparator(.hidden)
                }
                
                if !pinnedRecipes.isEmpty {
                    Section {
                        if isPinnedRecipesExpanded {
                            recipesList(pinnedRecipes)
                            
                            ListSectionFooterShape(cornerRadius: 10)
                                .stroke(lineWidth: 0.75)
                                .foregroundStyle(Color("Secondary").opacity(0.75))
                                .shadow(color: Color("Secondary").opacity(0.5), radius: 2)
                        }
                    } header: {
                        
                        ListSectionHeaderNew(title: "Pinned Recipes", isExpanded: $isPinnedRecipesExpanded)
                            .foregroundStyle(.primary)
                    }
                    .listRowSeparator(.hidden)
                }
                
                Section {
                    if isRecipesExpanded {
                        recipesList(sortedRecipes)
                        
                        if showProductionChains {
                            ListSectionFooterShape(cornerRadius: 10)
                                .stroke(lineWidth: 0.75)
                                .foregroundStyle(Color("Secondary").opacity(0.75))
                                .shadow(color: Color("Secondary").opacity(0.5), radius: 2)
                        }
                    }
                } header: {
                    if showProductionChains || !pinnedRecipes.isEmpty {
                        ListSectionHeaderNew(title: "Recipes", isExpanded: $isRecipesExpanded)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: 600)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func recipesList(_ recipes: [Recipe]) -> some View {
        ForEach(recipes) { recipe in
            listItem {
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .fontWeight(.bold)
                    
                    RecipeView(recipe: recipe)
                        .contentShape(Rectangle())
                }
            } contextMenu: {
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
            } onTapGesture: {
                selectedRecipe = recipe
            }
        }
    }
    
    private func productionList() -> some View {
        ForEach(productionChains) { productionChain in
            listItem {
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
            } contextMenu: {
                Button(role: .destructive) {
                    withAnimation {
                        storage[productionChainID: productionChain.id] = nil
                    }
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            } onTapGesture: {
                selectedProductionChain = productionChain
            }
        }
    }
    
    @ViewBuilder
    private func listItem<C: View, M: View>(
        @ViewBuilder content: () -> C,
        @ViewBuilder contextMenu: () -> M,
        onTapGesture: @escaping () -> Void
    ) -> some View {
        content()
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(.interaction, Rectangle())
            .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 8).inset(by: -10))
            .padding(.horizontal, 10)
            .onTapGesture(perform: onTapGesture)
            .contextMenu {
                contextMenu()
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
