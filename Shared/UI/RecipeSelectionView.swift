import SwiftUI

struct RecipeSelectionView: View {
    var item: Item
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var storage: BaseStorage
    @EnvironmentObject private var settings: Settings
    @State private var isShowingConfirmation = false
    
    @Binding var selectedRecipe: Recipe?
    
    private var favoriteRecipes: [Recipe] {
        storage[recipesFor: item.id].filter {
            $0.isFavorite
        }.sorted { lhs, _ in
            lhs.isDefault
        }
    }
    
    private var sortedRecipes: [Recipe] {
        storage[recipesFor: item.id].filter {
            !$0.isFavorite
        }.sorted { lhs, _ in
            lhs.isDefault
        }
    }
    
    var body: some View {
        List {
            if !favoriteRecipes.isEmpty {
                Section("Favorite Recipes") {
                    recipesList(favoriteRecipes)
                }
            }
            
            recipesList(sortedRecipes)
        }
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
            .onTapGesture {
                selectedRecipe = recipe
            }
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button {
                    storage[recipeID: recipe.id]?.isFavorite.toggle()
                } label: {
                    Label(
                        recipe.isFavorite ? "Unfavorite" : "Favorite",
                        systemImage: recipe.isFavorite ? "heart.slash" : "heart"
                    )
                }
                .tint(.yellow)
            }
            .listRowSeparator(.hidden)
            
            if recipe.id != recipes.last?.id {
                Spacer()
                    .frame(height: 20)
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
}

struct RecipeSelectionPreview: PreviewProvider {
    @StateObject static private var storage: BaseStorage = PreviewStorage()
    
    static private var turboMotor: Part {
        storage[partID: "turbo-motor"]!
    }

    static var previews: some View {
        RecipeSelectionView(item: turboMotor, selectedRecipe: .constant(nil))
            .environmentObject(storage)
            .environmentObject(Settings())
    }
}
