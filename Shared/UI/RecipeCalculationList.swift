import SwiftUI

struct RecipeCalculationList: View {
    @EnvironmentObject var storage: BaseStorage
    
    @Binding var isShowingStatistics: Bool
    
    @StateObject private var production: Production
    @Binding private var amount: Double
    
    @State private var recipeSelectionModel: RecipeSelectionModel?
    
    private var statisticsButton: some View {
        Button("Show item statistics") {
            isShowingStatistics = true
        }
        .buttonStyle(.borderedProminent)
        .padding(.vertical, 15)
    }
    
    var body: some View {
        VStack {
            statisticsButton
            
            List {
                ForEach(production.productionTree.arrayLevels) { node in
                    recipeTreeEntry(node)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .onAppear {
                production.storage = storage
                production.checkInput(for: production.recipe)
            }
            .onChange(of: amount) { newAmount in
                production.amount = newAmount
            }
            .sheet(item: $recipeSelectionModel) { recipeSelectionModel in
                RecipeSelectionForProductionItemView(
                    model: recipeSelectionModel
                )
            }
        }
        .sheet(isPresented: $isShowingStatistics) {
            NavigationView {
                CalculationStatistics(data: production.statistics, machines: production.machineStatistics)
                    .navigationBarTitle("Statistics for \(production.item.name)", displayMode: .inline)
                    .navigationBarItems(
                        trailing:
                            Button("Done") {
                                isShowingStatistics = false
                            }
                    )
            }
        }
    }
    
    init(item: Item, recipe: Recipe, amount: Binding<Double>, isShowingStatistics: Binding<Bool>) {
        _amount = amount
        _isShowingStatistics = isShowingStatistics
        _production = .init(wrappedValue: Production(item: item, recipe: recipe, amount: amount.wrappedValue))
    }
    
    private func recipeTreeEntry(_ tree: RecipeTree) -> some View {
        VStack(alignment: .leading) {
            Text(tree.element.recipe.name)
                .fontWeight(.semibold)
            
            HStack {
                ForEach(tree.element.recipe.input) { input in
                    Button {
                        if (input.item as? Part)?.rawResource == false {
                            recipeSelectionModel = .init(production: production, item: input.item, branch: tree)
                        }
                    } label: {
                        ItemCell(
                            item: input.item,
                            amountPerMinute: "\(tree.element.amount(for: input.item).formatted(.fractionFromZeroToFour))",
                            isSelected: (input.item as? Part)?.rawResource == true || tree.children.contains {
                                $0.element.item.id == input.item.id
                            }
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            
            HStack(spacing: 0) {
                Text("\(tree.element.numberOfMachines) x ")
                    .fontWeight(.semibold)
                
                Text(tree.element.recipe.machines[0].name)
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
            }
        }
    }
}

struct RecipeCalculationListPreviews: PreviewProvider {
    @StateObject private static var storage: BaseStorage = PreviewStorage()
    
    private static let partID = "reinforced-iron-plate"
    
    private static var item: Item {
        storage[partID: partID]!
    }
    
    private static var recipe: Recipe {
        storage[recipesFor: partID][0]
    }
    
    static var previews: some View {
        RecipeCalculationList(item: item, recipe: recipe, amount: .constant(40), isShowingStatistics: .constant(false))
            .environmentObject(storage)
    }
}

