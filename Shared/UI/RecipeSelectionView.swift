//
//  RecipeSelectionView.swift
//  RecipeSelectionView
//
//  Created by Slava Nagornyak on 17.07.2021.
//

import SwiftUI

struct RecipeSelectionView_Old: View {
    let item: Item
    @Binding var selectedRecipe: Recipe?
    
    private var sortedRecipes: [Recipe] {
        item.recipes.sorted { lhs, _ in
            lhs.isDefault
        }
    }
    
    var body: some View {
        List(selection: $selectedRecipe) {
            ForEach(sortedRecipes) { recipe in
                Section(recipe.name) {
                    Button {
                        selectedRecipe = recipe
                    } label: {
                        RecipeView(recipe: recipe)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct RecipeSelectionView: View {
    var item: Item
    
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingConfirmation = false
    
    @Binding var selectedRecipe: Recipe?
    
    private var favoriteRecipes: [Recipe] {
        item.recipes.filter {
            $0.isFavorite
        }.sorted { lhs, _ in
            lhs.isDefault
        }
    }
    
    private var sortedRecipes: [Recipe] {
        item.recipes.filter {
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
                
                RecipeView(recipe: recipe)
                    .contentShape(Rectangle())
                
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
            .contextMenu {
                Button {
                    if recipe.isFavorite {
                        UserDefaults.standard.removeObject(forKey: recipe.id)
                    } else {
                        UserDefaults.standard.set(true, forKey: recipe.id)
                    }
                } label: {
                    Label(
                        recipe.isFavorite ? "Unfavorite" : "Favorite",
                        systemImage:recipe.isFavorite ? "heart.slash" : "heart")
                }
            }
            .listRowSeparator(.hidden)
            
            if recipe.id != recipes.last?.id {
                Spacer()
                    .frame(height: 20)
                    .listRowSeparator(.hidden)
            }
        }
    }
}

struct RecipeSelectionPreview: PreviewProvider {
    static let turboMotor = Storage[itemName: "Turbo Motor"]!
    
    static var previews: some View {
        RecipeSelectionView(item: turboMotor, selectedRecipe: .constant(nil))
    }
}
