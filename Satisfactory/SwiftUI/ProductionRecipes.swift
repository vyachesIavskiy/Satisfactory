import SwiftUI

struct ProductionRecipes: View {
    var item: Item
    
    var body: some View {
        VStack {
            ItemViewV4(item: item)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 40) {
                    ForEach(item.recipes) { recipe in
                        RecipeViewV3(recipe: recipe, isSelected: .constant(false))
                    }
                }
                .padding(.vertical, 50)
                .padding(.horizontal)
            }
        }
    }
}

struct ProductionRecipes_Previews: PreviewProvider {
    static var previews: some View {
        ProductionRecipes(item: Storage.shared[partName: "Computer"]!)
    }
}
