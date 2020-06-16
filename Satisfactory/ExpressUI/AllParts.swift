import SwiftUI

struct AllParts: View {
    var parts: [Part] {
        Storage.shared.parts
    }
    
    var body: some View {
        NavigationView {
            List(parts) { part in
                if part.recipes.isEmpty {
                    self.itemView(part: part)
                } else {
                    NavigationLink(destination: RecipesForPart(part: part)) {
                        self.itemView(part: part)
                    }
                }
            }
            .navigationBarTitle("Parts")
        }
    }
    
    func itemView(part: Part) -> some View {
        HStack {
            Image(part.name)
                .resizable()
                .frame(width: 50, height: 50)
            Text(part.name)
        }
    }
}

struct RecipesForPart: View {
    var part: Part
    
    var body: some View {
        List(part.recipes) { recipe in
            NavigationLink(destination: RecipesForProduction(selectedRecipe: recipe)) {
                HStack {
                    ForEach(recipe.input) { input in
                        Text("\(input.amount)")
                        Image(input.item.name)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    
                    Image(systemName: "arrowtriangle.right.fill")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                    
                    ForEach(recipe.output) { output in
                        Text("\(output.amount)")
                        Image(output.item.name)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
            }
        }
        .navigationBarTitle(part.name)
    }
}

struct RecipesForProduction: View {
    var selectedRecipe: Recipe
    
    var body: some View {
        List(selectedRecipe.allInputItems, id: \.id) { item in
            Text(item.name)
        }
    }
    
    func header(item: Item) -> some View {
        HStack {
            Image(item.name)
                .resizable()
                .frame(width: 50, height: 50)
            Text(item.name)
        }
    }
}

struct AllParts_Previews: PreviewProvider {
    static var previews: some View {
        AllParts()
    }
}
