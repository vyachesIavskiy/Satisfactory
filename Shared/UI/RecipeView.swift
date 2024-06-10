import SwiftUI

struct RecipeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var settings: Settings
    
    var recipe: Recipe
    
    private let gridItem = GridItem(.fixed(70), spacing: 15)
    
    private var compactBody: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(spacing: 10) {
                ForEach(recipe.output) { output in
                    ItemInRecipeView(recipePart: output, isOutput: true)
                }
            }
            
            LazyVGrid(columns: [gridItem, gridItem], alignment: .leading, spacing: 10) {
                ForEach(recipe.input) { input in
                    ItemInRecipeView(recipePart: input, isOutput: false)
                }
            }
        }
    }
    
    private var regularBody: some View {
        HStack(spacing: 25) {
            HStack(spacing: 10) {
                ForEach(recipe.output) { output in
                    ItemInRecipeView(recipePart: output, isOutput: true)
                }
            }
            
            HStack(spacing: 10) {
                ForEach(recipe.input) { input in
                    ItemInRecipeView(recipePart: input, isOutput: false)
                }
            }
        }
    }
    
    @ViewBuilder
    private var rowBody: some View {
        VStack(spacing: 12) {
            VStack(spacing: 6) {
                ForEach(recipe.output) { output in
                    ItemRowInRecipeView(recipePart: output, isOutput: true)
                }
            }
            .padding(.trailing, 24)
            
            VStack(spacing: 6) {
                ForEach(recipe.input) { input in
                    ItemRowInRecipeView(recipePart: input, isOutput: false)
                }
            }
            .padding(.leading, 24)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading/*, spacing: 24*/) {
            Text(recipe.name)
                .fontWeight(.medium)
            
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
        .frame(maxWidth: .infinity)
    }
}

struct ItemInRecipeView: View {
    let recipePart: Recipe.RecipePart
    let isOutput: Bool
    
    private var amountPerMinuteDisplayString: String {
        recipePart.amountPerMinute.formatted(.fractionFromZeroToFour)
    }
    
    var body: some View {
        ItemCell(
            item: recipePart.item,
            amountPerMinute: amountPerMinuteDisplayString,
            isOutput: isOutput
        )
    }
}

struct ItemRowInRecipeView: View {
    let recipePart: Recipe.RecipePart
    let isOutput: Bool
    
    private var amountPerMinuteDisplayString: String {
        recipePart.amountPerMinute.formatted(.fractionFromZeroToFour)
    }
    
    var body: some View {
        ItemRowInRecipe2(
            item: recipePart.item,
            amountPerMinute: amountPerMinuteDisplayString,
            isOutput: isOutput
        )
    }
}

#if DEBUG

#Preview("Recipe view (icon)") {
    let storage: Storage = PreviewStorage()
    let settings = Settings()
    settings.itemViewStyle = .icon
    
    return ScrollView {
        VStack(alignment: .leading, spacing: 30) {
            RecipeView(recipe: storage[recipesFor: "iron-ingot"][0])
            RecipeView(recipe: storage[recipesFor: "water"][2])
            RecipeView(recipe: storage[recipesFor: "modular-frame"][0])
            RecipeView(recipe: storage[recipesFor: "crystal-oscillator"][0])
            RecipeView(recipe: storage[recipesFor: "computer"][1])
            RecipeView(recipe: storage[recipesFor: "non-fissile-uranium"][0])
        }
    }
    .environmentObject(settings)
}

#Preview("Recipe view (row)") {
    let storage: Storage = PreviewStorage()
    let settings = Settings()
    settings.itemViewStyle = .row
    
    return ScrollView {
        VStack(alignment: .leading, spacing: 30) {
            RecipeView(recipe: storage[recipesFor: "iron-ingot"][0])
            RecipeView(recipe: storage[recipesFor: "water"][2])
            RecipeView(recipe: storage[recipesFor: "modular-frame"][0])
            RecipeView(recipe: storage[recipesFor: "crystal-oscillator"][0])
            RecipeView(recipe: storage[recipesFor: "computer"][1])
            RecipeView(recipe: storage[recipesFor: "non-fissile-uranium"][0])
        }
        .padding()
    }
    .environmentObject(settings)
}

#endif
