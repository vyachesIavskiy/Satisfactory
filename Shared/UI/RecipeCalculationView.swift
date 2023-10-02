import SwiftUI

struct RecipeCalculationView: View {
    let item: Item
    
    @State private var recipe: Recipe?
    
    @State private var productionChain: ProductionChain?
    
    @State private var isShowingAlert = false
    
    @State private var isShowingDismissAlert = false
    
    @State private var isShowingStatistics = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        RecipeSelectionView(
            item: item,
            selectedRecipe: $recipe,
            selectedProductionChain: $productionChain
        )
        .navigationTitle(item.name)
        .fullScreenCover(item: $recipe) { recipe in
            NavigationStack {
                RecipeCalculationList(item: item, recipe: recipe)
            }
        }
        .fullScreenCover(item: $productionChain) { productionChain in
            NavigationStack {
                RecipeCalculationList(productionChain: productionChain)
            }
        }
    }
    
    init(item: Item) {
        self.item = item
    }
}

struct RecipeCalculationPreviews: PreviewProvider {
    @StateObject private static var storage: Storage = PreviewStorage()
    
    private static var item: Item {
        storage[partID: "turbo-motor"]!
    }
    
    static var previews: some View {
        NavigationView {
            RecipeCalculationView(item: item)
        }
        .navigationViewStyle(.stack)
        .environmentObject(storage)
        .environmentObject(Settings())
    }
}

