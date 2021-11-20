import SwiftUI

struct RecipeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var settings: Settings
    
    var recipe: Recipe
    
    private let gridItem = GridItem(.adaptive(minimum: 70, maximum: .infinity), spacing: 10)
    
    private var compactBody: some View {
        HStack {
            LazyVGrid(columns: [gridItem]) {
                ForEach(recipe.input) { input in
                    ItemInRecipeView(recipePart: input)
                }
            }
            .frame(width: recipe.input.count > 1 ? 150 : 70)
            
            Image(systemName: "arrowtriangle.right.fill")
                .font(.title)
                .foregroundColor(.secondary)
            
            HStack {
                ForEach(recipe.output) { output in
                    ItemInRecipeView(recipePart: output)
                }
            }
        }
    }
    
    private var regularBody: some View {
        HStack {
            HStack {
                ForEach(recipe.input) { input in
                    ItemInRecipeView(recipePart: input)
                }
            }
            
            Image(systemName: "arrowtriangle.right.fill")
                .font(.title)
                .foregroundColor(.gray)
            
            HStack {
                ForEach(recipe.output) { output in
                    ItemInRecipeView(recipePart: output)
                }
            }
        }
    }
    
    private var rowBody: some View {
        VStack(spacing: 15) {
            VStack(spacing: 0) {
                ForEach(recipe.input) { input in
                    ItemRowInRecipeView(recipePart: input)
                }
            }
            .cornerRadius(4)
            
            HStack {
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
            
            
            VStack {
                ForEach(recipe.output) { output in
                    ItemRowInRecipeView(recipePart: output)
                }
            }
            .cornerRadius(4)
        }
    }
    
    var body: some View {
        switch settings.itemViewStyle {
        case .icon:
            if horizontalSizeClass == .compact {
                compactBody
            } else {
                regularBody
            }
            
        case .row:
            rowBody
        }
    }
}

struct ItemInRecipeView: View {
    let recipePart: Recipe.RecipePart
    
    private var amountPerMinuteDisplayString: String {
        recipePart.amountPerMinute.formatted(.fractionFromZeroToFour)
    }
    
    var body: some View {
        ItemCell(item: recipePart.item, amountPerMinute: amountPerMinuteDisplayString)
    }
}

struct ItemRowInRecipeView: View {
    let recipePart: Recipe.RecipePart
    
    private var amountPerMinuteDisplayString: String {
        recipePart.amountPerMinute.formatted(.fractionFromZeroToFour)
    }
    
    var body: some View {
        ItemRowInRecipe(item: recipePart.item, amountPerMinute: amountPerMinuteDisplayString)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static private var storage: BaseStorage = PreviewStorage()
    
    static var previews: some View {
        ZStack {
            LinearGradient(
                colors: [.red, .orange, .yellow, .green, .cyan, .blue, .purple],
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                RecipeView(recipe: storage[recipesFor: "iron-ingot"][0])
                RecipeView(recipe: storage[recipesFor: "modular-frame"][0])
                RecipeView(recipe: storage[recipesFor: "computer"][1])
            }
            .environmentObject(Settings())
        }
    }
}
