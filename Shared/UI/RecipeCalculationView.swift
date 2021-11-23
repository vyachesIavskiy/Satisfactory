import SwiftUI

struct RecipeCalculationView: View {
    let item: Item
    
    @State private var amount: Double = 1
    
    @State private var recipe: Recipe?
    
    @State private var productionChain: ProductionChain?
    
    @State private var isShowingAlert = false
    
    @State private var isShowingStatistics = false
    
    var body: some View {
        VStack {
            RecipeCalculatorHeader(item: item, amount: $amount)
                .padding(.horizontal)
                .frame(maxWidth: 700)
            
            if let recipe = recipe {
                RecipeCalculationList(item: item, recipe: recipe, amount: $amount, isShowingStatistics: $isShowingStatistics)
            } else if let productionChain = productionChain {
                RecipeCalculationList(productionChain: productionChain, amount: $amount, isShowingStatistics: $isShowingStatistics)
            } else {
                RecipeSelectionView(
                    item: item,
                    selectedRecipe: $recipe,
                    selectedProductionChain: $productionChain
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing:
                HStack {
                    if recipe != nil || productionChain != nil {
                        Button("Change recipe") {
                            isShowingAlert = true
                        }
                        .alert(isPresented: $isShowingAlert) {
                            Alert(
                                title: Text("Change recipe"),
                                message: Text("If you change recipe, all previously selected recipes will be dismissed"),
                                primaryButton: .destructive(Text("Change")) {
                                    recipe = nil
                                    productionChain = nil
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                }
        )
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
        RecipeCalculationView(item: item)
            .environmentObject(storage)
    }
}
