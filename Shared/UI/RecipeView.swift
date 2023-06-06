import SwiftUI

struct RecipeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var settings: Settings
    
    var recipe: Recipe
    
    private let gridItem = GridItem(.adaptive(minimum: 66, maximum: .infinity), spacing: 10)
    
    private var compactBody: some View {
        HStack(spacing: 25) {
            LazyVGrid(columns: [gridItem], spacing: 15) {
                ForEach(recipe.output) { output in
                    ItemInRecipeView(recipePart: output, isOutput: true)
                }
            }
            .frame(width: 70)
            
            LazyVGrid(columns: [gridItem], spacing: 15) {
                ForEach(recipe.input) { input in
                    ItemInRecipeView(recipePart: input, isOutput: false)
                }
            }
            .frame(width: recipe.input.count > 1 ? 150 : 70)
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
    
    private var rowBody: some View {
        HStack(spacing: 25) {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(recipe.output) { output in
                    ItemRowInRecipeView(recipePart: output, isOutput: true)
                }
            }
            
            VStack(alignment: .leading, spacing: 15) {
                ForEach(recipe.input) { input in
                    ItemRowInRecipeView(recipePart: input, isOutput: false)
                }
            }
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
        ItemRowInRecipe(
            item: recipePart.item,
            amountPerMinute: amountPerMinuteDisplayString,
            isOutput: isOutput
        )
    }
}

struct RecipeView_Previews: PreviewProvider {
    static private var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        VStack(alignment: .leading, spacing: 10) {
            RecipeView(recipe: storage[recipesFor: "iron-ingot"][0])
            RecipeView(recipe: storage[recipesFor: "modular-frame"][0])
            RecipeView(recipe: storage[recipesFor: "computer"][1])
            RecipeView(recipe: storage[recipesFor: "non-fissile-uranium"][0])
        }
        .environmentObject(Settings())
    }
}
