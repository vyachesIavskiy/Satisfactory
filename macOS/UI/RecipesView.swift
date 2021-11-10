import SwiftUI

struct RecipesView: View {
    var recipes: [Recipe]
    @Binding var selectedRecipe: Recipe?
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                HStack {
                    ForEach(recipe.input) { input in
                        HStack {
                            Text("\(input.amount)")
                            Image(input.item.name)
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    Image(systemName: "arrowtriangle.right.square")
                    ForEach(recipe.output) { output in
                        HStack {
                            Text("\(output.amount)")
                            Image(output.item.name)
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                }.onTapGesture {
                    if selectedRecipe == recipe {
                        selectedRecipe = nil
                    } else {
                        selectedRecipe = recipe
                    }
                }
            }
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView(recipes: Storage.shared[partName: "Reinforced Iron Plate"]!.recipes, selectedRecipe: .constant(nil))
    }
}
