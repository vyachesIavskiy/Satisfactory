import SwiftUI

struct ItemRecipeSelection: View {
    var item: Item
    @State private var selectedRecipe: Recipe? {
        willSet {
            if let newValue = newValue {
                manager.add(recipe: newValue)
            } else {
                guard let selectedRecipe = selectedRecipe else { return }
                manager.remove(recipe: selectedRecipe)
            }
        }
    }
    @ObservedObject var manager: RecipeManager
    
    var body: some View {
        VStack(alignment: .leading) {
            ItemRow(item: item)
                .padding(.leading, 25)
            
            if (item as? Part)?.rawResource == true {
                Text("Exctract this item")
            } else {
                RecipesView(recipes: item.recipes, selectedRecipe: $selectedRecipe)
            }
        }
    }
}

struct ItemRecipeSelection_Previews: PreviewProvider {
    static var previews: some View {
        ItemRecipeSelection(item: Storage.shared[partName: "Alclad Aluminum Sheet"]!, manager: RecipeManager())
    }
}
