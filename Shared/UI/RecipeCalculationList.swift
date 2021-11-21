import SwiftUI

struct RecipeCalculationList: View {
    @EnvironmentObject var storage: Storage
    @EnvironmentObject var settings: Settings
    
    @Binding var isShowingStatistics: Bool
    @State private var isShowingSaveAlert = false
    
    @StateObject private var production: Production
    @Binding private var amount: Double
    
    @State private var recipeSelectionModel: RecipeSelectionModel?
    
    private var isStartingAnew = true
    
    private var statisticsButton: some View {
        Button("Show item statistics") {
            isShowingStatistics = true
        }
        .buttonStyle(.borderedProminent)
        .padding(.vertical, 15)
    }
    
    private var saveProductionButton: some View {
        Button("Save production chain") {
            production.save()
            
            isShowingSaveAlert = true
        }
        .buttonStyle(.borderedProminent)
        .padding(.vertical, 15)
        .alert("Saved!", isPresented: $isShowingSaveAlert) {
            Button("OK") {
                isShowingSaveAlert = false
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                statisticsButton
                saveProductionButton
            }
            
            List {
                ForEach(production.productionChainArray) { node in
                    HStack {
                        Spacer()
                        recipeTreeEntry(node)
                            .frame(maxWidth: 700)
                        Spacer()
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .onAppear {
                production.storage = storage
                if isStartingAnew {
                    production.checkInput(for: production.recipe)
                }
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
        .onAppear {
            if !isStartingAnew {
                amount = production.amount
                production.amount = amount
            }
        }
    }
    
    init(item: Item, recipe: Recipe, amount: Binding<Double>, isShowingStatistics: Binding<Bool>) {
        _amount = amount
        _isShowingStatistics = isShowingStatistics
        _production = .init(wrappedValue: Production(item: item, recipe: recipe, amount: amount.wrappedValue))
    }
    
    init(productionChain: ProductionChain, amount: Binding<Double>, isShowingStatistics: Binding<Bool>) {
        _amount = amount
        _isShowingStatistics = isShowingStatistics
        _production = .init(wrappedValue: Production(productionChain: productionChain))
        isStartingAnew = false
    }
    
    private func recipeTreeEntry(_ tree: RecipeTree) -> some View {
        VStack {
            Text(tree.element.recipe.name)
                .fontWeight(.semibold)
            
            switch settings.itemViewStyle {
            case .icon:
                itemCells(tree: tree)
                
            case .row:
                itemRows(tree: tree)
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
    
    private func itemCells(tree: RecipeTree) -> some View {
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
    }
    
    private func itemRows(tree: RecipeTree) -> some View {
        VStack {
            ForEach(tree.element.recipe.input) { input in
                Button {
                    if (input.item as? Part)?.rawResource == false {
                        recipeSelectionModel = .init(production: production, item: input.item, branch: tree)
                    }
                } label: {
                    ItemRowInRecipe(
                        item: input.item,
                        amountPerMinute: "\(tree.element.amount(for: input.item).formatted(.fractionFromZeroToFour))",
                        isSelected: (input.item as? Part)?.rawResource == true || tree.children.contains { $0.element.item.id == input.item.id }
                    )
                        .cornerRadius(4)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct RecipeCalculationListPreviews: PreviewProvider {
    @StateObject private static var storage: Storage = PreviewStorage()
    
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
            .environmentObject(Settings())
    }
}

