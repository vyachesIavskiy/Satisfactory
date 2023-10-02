import SwiftUI

struct RecipeCalculationView: View {
    let item: Item
    
    @State private var amount: Double = 1
    
    @State private var recipe: Recipe?
    
    @State private var productionChain: ProductionChain?
    
    @State private var isShowingAlert = false
    
    @State private var isShowingDismissAlert = false
    
    @State private var isShowingStatistics = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            RecipeCalculatorHeader(item: item, amount: $amount)
                .padding(.horizontal)
                .frame(maxWidth: 700)
            
            RecipeSelectionView(
                item: item,
                selectedRecipe: $recipe,
                selectedProductionChain: $productionChain
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(item: $recipe) { recipe in
            NavigationStack {
                RecipeCalculationList(item: item, recipe: recipe, amount: amount)
            }
        }
        .fullScreenCover(item: $productionChain) { productionChain in
            NavigationStack {
                RecipeCalculationList(productionChain: productionChain, amount: amount)
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

