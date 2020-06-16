import SwiftUI

struct RecipeForProductionSelection: View {
    var item: Item
    var recipe: Recipe
    
    var body: some View {
        VStack {
            Text("Production for \(item.name)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, -20)
            
            ForEach(recipe.input, id: \.self) { input in
                ProductionRecipes(item: input.item)
            }
        }
    }
    
    init(item: Item, recipe: Recipe) {
        self.item = item
        self.recipe = recipe
        
        UITableView.appearance().separatorColor = .clear
    }
}

struct RecipeForProductionSelection_Previews: PreviewProvider {
    static var previews: some View {
        RecipeForProductionSelection(
            item: Storage.shared[partName: "Turbo Motor"]!,
            recipe: Storage.shared[recipesFor: Storage.shared[partName: "Turbo Motor"]!.id][0]
        )
    }
}
