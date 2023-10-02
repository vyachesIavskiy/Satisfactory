import SwiftUI

struct RecipeCalculationList: View {
    @EnvironmentObject var storage: Storage
    @EnvironmentObject var settings: Settings
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isShowingSaveAlert = false
    @State private var productionChainSaveName = ""
    @State private var recipeSelectionModel: RecipeSelectionModel?
    @State private var isShowingStatistics = false
    @State private var isShowingAlert = false
    
    @StateObject private var production: Production
    
    @State private var amount = 1.0
    
    private var isStartingAnew = true
    
    private var statisticsButton: some View {
        Button("Show item statistics") {
            isShowingStatistics = true
        }
        .buttonStyle(.borderedProminent)
        .padding(.vertical, 15)
    }
    
    var body: some View {
        List {
            ForEach(production.productionChainArray) { node in
                HStack {
                    Spacer()
                    recipeTreeEntry(node, showName: node.element.item.id != production.item.id)
                        .frame(maxWidth: 700)
                    Spacer()
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .safeAreaInset(edge: .top) {
            RecipeCalculatorHeader(item: production.item, amount: $amount)
                .frame(maxWidth: 700)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background(.bar)
        }
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
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .destructive) {
                    isShowingAlert = true
                } label: {
                    Image(systemName: "xmark")
                }
                .alert(isPresented: $isShowingAlert) {
                    Alert(
                        title: Text("Exiting"),
                        message: Text("Are you sure you would like to exit? All unsaved changes will be lost."),
                        primaryButton: .destructive(Text("Exit")) {
                            dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    production.save()
                    
                    isShowingSaveAlert = true
                }
                .alert("Saved!", isPresented: $isShowingSaveAlert) {
                    Button("OK") {}
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isShowingStatistics = true
                } label: {
                    Image(systemName: "checklist.unchecked")
                }
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
    
    init(item: Item, recipe: Recipe) {
        _production = .init(wrappedValue: Production(item: item, recipe: recipe, amount: 1.0))
    }
    
    init(productionChain: ProductionChain) {
        _production = .init(wrappedValue: Production(productionChain: productionChain))
        isStartingAnew = false
    }
    
    private func recipeTreeEntry(_ tree: RecipeTree, showName: Bool) -> some View {
        VStack {
            if showName {
                Text(tree.element.recipe.name)
                    .fontWeight(.semibold)
            }
            
            switch settings.itemViewStyle {
            case .icon:
                itemCells(tree: tree)
                
            case .row:
                itemRows(tree: tree)
            }
            
            HStack(spacing: 0) {
                Text("\(tree.element.numberOfMachines.formatted(.fractionFromZeroToFour)) x ")
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
                    if let part = input.item as? Part {
                        if !part.rawResource {
                            recipeSelectionModel = .init(production: production, item: input.item, branch: tree)
                        }
                    } else {
                        recipeSelectionModel = .init(production: production, item: input.item, branch: tree)
                    }
                } label: {
                    ItemCell(
                        item: input.item,
                        amountPerMinute: "\(tree.element.amount(for: input.item).formatted(.fractionFromZeroToFour))",
                        isSelected: tree.children.contains {
                            $0.element.item.id == input.item.id
                        },
                        isExtractable: (input.item as? Part)?.rawResource == true
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
                        isOutput: false,
                        isSelected: tree.children.contains { $0.element.item.id == input.item.id },
                        isExtractable: (input.item as? Part)?.rawResource == true
                    )
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
        NavigationStack {
            RecipeCalculationList(item: item, recipe: recipe)
        }
        .environmentObject(storage)
        .environmentObject(Settings())
    }
}

