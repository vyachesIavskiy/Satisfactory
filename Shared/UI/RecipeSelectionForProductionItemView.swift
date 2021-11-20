import SwiftUI

class RecipeSelectionModel: ObservableObject, Identifiable {
    @ObservedObject var production: Production
    
    let item: Item
    let branch: Tree<RecipeElement>
    
    var id: UUID { branch.element.id }
    
    var hasMultipleOfItem: Bool { production.hasMultiple(of: item) }
    
    init(production: Production, item: Item, branch: Tree<RecipeElement>) {
        self.production = production
        self.item = item
        self.branch = branch
    }
    
    func addOne(recipe: Recipe) {
        production.add(recipe: recipe, for: item, at: branch)
    }
    
    func addRemaining(recipe: Recipe) {
        production.addRemaining(recipe: recipe, for: item)
    }
    
    func add(recipe: Recipe) {
        production.add(recipe: recipe, for: item)
    }
}

struct RecipeSelectionForProductionItemView: View {
    @ObservedObject var model: RecipeSelectionModel
    
    @State private var selectedRecipe: Recipe?
    @State private var isShowingConfirmation = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        RecipeSelectionView(
            item: model.item,
            selectedRecipe: $selectedRecipe,
            selectedProductionChain: .constant(nil),
            showProductionChains: false
        )
            .onChange(of: selectedRecipe) { newRecipe in
                guard let newRecipe = newRecipe else { return }

                if model.hasMultipleOfItem {
                    isShowingConfirmation = true
                } else {
                    model.addOne(recipe: newRecipe)
                    dismiss()
                }
            }
            .confirmationDialog("Add for all such items or only for this one?", isPresented: $isShowingConfirmation) {
                Button("For all") {
                    model.add(recipe: selectedRecipe!)
                    dismiss()
                }

                Button("This only") {
                    model.addOne(recipe: selectedRecipe!)
                    dismiss()
                }

                Button("Remaining") {
                    model.addRemaining(recipe: selectedRecipe!)
                    dismiss()
                }

                Button("Cancel", role: .cancel) {}
            }
    }
}

//struct RecipeSelectionForProductionItemPreviews: PreviewProvider {
//    static var previews: some View {
//        RecipeSelectionForProductionItemView(model: <#T##RecipeSelectionModel#>)
//    }
//}
