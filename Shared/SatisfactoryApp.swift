import SwiftUI

@main
struct SatisfactoryApp: App {
    @State private var isLoaded = false
    @StateObject private var storage: BaseStorage = Storage()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoaded {
                    ItemListView()
                } else {
                    LoadingView(isLoaded: $isLoaded)
                }
            }
            .environmentObject(storage)
        }
    }
}

struct Downloader {
    var dataProvider: DataProviderProtocol
    var storage: BaseStorage
    
    func execute() async {
        storage.version = await dataProvider.version
        
        storage.parts = await dataProvider.parts.map { part in
            Part(
                id: part.id,
                name: part.name,
                partType: PartType(rawValue: part.partType)!,
                tier: Tier(rawValue: part.tier)!,
                milestone: part.milestone,
                sortingPriority: part.sortingPriority,
                rawResource: part.rawResource
            )
        }
        
        storage.equipments = await dataProvider.equipments.map { equipment in
            Equipment(
                id: equipment.id,
                name: equipment.name,
                slot: EquipmentSlot(rawValue: equipment.slot)!,
                fuel: storage[partID: equipment.fuel ?? ""],
                ammo: storage[partID: equipment.ammo ?? ""],
                consumes: storage[partID: equipment.consumes ?? ""]
            )
        }
        
        storage.buildings = await dataProvider.buildings.map { building in
            Building(
                id: building.id,
                name: building.name,
                buildingType: BuildingType(rawValue: building.buildingType)!
            )
        }
        
        storage.vehicles = await dataProvider.vehicles.map { vehicle in
            Vehicle(
                id: vehicle.id,
                name: vehicle.name,
                fuel: vehicle.fuel.compactMap { fuel in
                    storage[partID: fuel]
                }
            )
        }
        
        storage.recipes = await dataProvider.recipes.map { recipe in
            Recipe(
                id: recipe.id,
                name: recipe.name,
                input: recipe.input.map { input in
                    Recipe.RecipePart(item: storage[itemID: input.id]!, amount: input.amount)
                },
                output: recipe.output.map { output in
                    Recipe.RecipePart(item: storage[itemID: output.id]!, amount: output.amount)
                },
                machines: recipe.machines.compactMap { machine in
                    storage[buildingID: machine]
                },
                duration: recipe.duration,
                isDefault: recipe.isDefault,
                isFavorite: false
            )
        }
        
        storage.save()
    }
}

struct LoadingView: View {
    @Environment(\.dataProvider) private var dataProvider
    @EnvironmentObject private var storage: BaseStorage
    
    @Binding var isLoaded: Bool
    
    @State private var status = Status.loading
    
    private enum Status: String {
        case loading = ""
        case downloading = "Downloading"
    }
    
    var body: some View {
        ProgressView(status.rawValue)
            .task {
                let version = await dataProvider.version
                let currentVersion = storage.version
                if version > currentVersion {
                    status = .downloading
                    await Downloader(dataProvider: dataProvider, storage: storage).execute()
                } else {
                    storage.load()
                }
                isLoaded = true
            }
    }
}

struct RecipeCalculatorHeader: View {
    let item: Item
    @Binding var amount: Double
    
    var body: some View {
        HStack {
            ItemRow(item: item)
            
            Spacer()
            
            TextField("", value: $amount, format: .fractionFromZeroToFour)
                .textFieldStyle(.roundedBorder)
                .labelsHidden()
                .multilineTextAlignment(.center)
                .frame(maxWidth: 100)
            
            Text("/ min")
                .fontWeight(.semibold)
        }
    }
}

struct RecipeCalculationList: View {
    @Binding var isShowingStatistics: Bool
    
    @StateObject private var recipeTree: RecipeTreeNode
    @Binding private var amount: Double
    
    @State private var recipeSelectionModel: RecipeSelectionModel?
    
    var gridItems: [GridItem] {
        recipeTree.allNodes.map { _ in
            GridItem(.flexible(minimum: 70, maximum: .infinity))
        }
    }
    
    var body: some View {
        VStack {
            Button("Show item statistics") {
                isShowingStatistics = true
            }
            .buttonStyle(.borderedProminent)
            .padding(.vertical, 15)
            
            List {
                ForEach(recipeTree.allNodes) { node in
                    VStack(alignment: .leading) {
                        Text(node.recipe.name)
                            .fontWeight(.semibold)
                        
                        HStack {
                            ForEach(node.recipe.input) { input in
                                Button {
                                    recipeSelectionModel = .init(recipeTree: recipeTree, itemID: input.item.id, nodeID: node.id)
                                } label: {
                                    ItemCell(
                                        item: input.item,
                                        amountPerMinute: "\(node.amount(for: input.item).formatted(.fractionFromZeroToFour))",
                                        isSelected: node.hasRecipe(for: input.item)
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        
                        HStack(spacing: 0) {
                            Text("\(Int(ceil(node.numberOfMachines))) x ")
                                .fontWeight(.semibold)
                            
                            Text(node.recipe.machines[0].name)
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .onChange(of: amount) { newAmount in
                recipeTree.amount = newAmount
            }
            .onAppear {
                recipeTree.checkInput(for: recipeTree.recipe)
            }
            .sheet(item: $recipeSelectionModel) { recipeSelectionModel in
                RecipeSelectionForProductionItemView(
                    model: recipeSelectionModel
                )
            }
        }
        .sheet(isPresented: $isShowingStatistics) {
            NavigationView {
                CalculationStatistics(data: recipeTree.statistics, machines: recipeTree.machineStatistics)
                    .navigationBarTitle("Statistics for \(recipeTree.item.name)", displayMode: .inline)
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
        _recipeTree = .init(wrappedValue: .init(item: item, recipe: recipe, amount: amount.wrappedValue))
    }
}

struct RecipeCalculationView: View {
    let item: Item
    
    @State private var amount: Double = 1
    
    @State private var recipe: Recipe?
    
    @State private var isShowingAlert = false
    
    @State private var isShowingStatistics = false
    
    var body: some View {
        VStack {
            RecipeCalculatorHeader(item: item, amount: $amount)
                .padding(.horizontal)
            
            if let recipe = recipe {
                RecipeCalculationList(item: item, recipe: recipe, amount: $amount, isShowingStatistics: $isShowingStatistics)
            } else {
                RecipeSelectionView(item: item, selectedRecipe: $recipe)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing:
                HStack {
                    if recipe != nil {
                        Button("Change recipe") {
                            isShowingAlert = true
                        }
                        .alert(isPresented: $isShowingAlert) {
                            Alert(
                                title: Text("Change recipe"),
                                message: Text("If you change recipe, all previously selected recipes will be dismissed"),
                                primaryButton: .destructive(Text("Change")) {
                                    recipe = nil
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

struct CalculationStatisticsModel: Identifiable {
    let item: Item
    var amount: Double
    
    var id: String { item.id }
}

extension Array where Element == CalculationStatisticsModel {
    func sorted() -> Self {
        sorted {
            guard let left = $0.item as? Part, let right = $1.item as? Part else { return false }
            
            return left.sortingPriority > right.sortingPriority
        }
    }
}

struct CalculationMachineStatisticsModel: Identifiable {
    let recipe: Recipe
    let item: Item
    var amount: Double
    var machine: Building {
        recipe.machines[0]
    }
    
    var id: String { machine.id }
}

struct CalculationStatistics: View {
    var data: [CalculationStatisticsModel]
    var machines: [CalculationMachineStatisticsModel]
    
    var body: some View {
        List {
            Section(header: Text("Items")) {
                ForEach(data.sorted()) { entry in
                    HStack {
                        ItemRow(item: entry.item)
                        Spacer()
                        Text("\(entry.amount.formatted(.fractionFromZeroToFour)) / min")
                            .fontWeight(.semibold)
                    }
                }
            }
            
            Section(header: Text("Machines")) {
                ForEach(machines) { machine in
                    HStack {
                        HStack(spacing: 10) {
                            Image(machine.machine.name)
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            Text(machine.machine.name)
                        }
                        
                        Spacer()
                        
                        Text("\(Int(ceil(machine.amount)))")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

class RecipeSelectionModel: ObservableObject, Identifiable {
    @EnvironmentObject private var storage: BaseStorage
    
    @ObservedObject var recipeTree: RecipeTreeNode
    let itemID: String
    let nodeID: UUID
    
    var id: UUID { nodeID }
    
    var item: Item {
        storage[itemID: itemID]!
    }
    
    var hasMultipleOfItem: Bool { recipeTree.hasMultiple(of: item) }
    
    init(recipeTree: RecipeTreeNode, itemID: String, nodeID: UUID) {
        self.recipeTree = recipeTree
        self.itemID = itemID
        self.nodeID = nodeID
    }
    
    func addOne(recipe: Recipe) {
        recipeTree.add(recipe: recipe, for: item, at: nodeID)
    }
    
    func addRemaining(recipe: Recipe) {
        recipeTree.addRemaining(recipe: recipe, for: item)
    }
    
    func add(recipe: Recipe) {
        recipeTree.add(recipe: recipe, for: item)
    }
}

struct RecipeSelectionForProductionItemView: View {
    @ObservedObject var model: RecipeSelectionModel
    
    @State private var selectedRecipe: Recipe?
    @State private var isShowingConfirmation = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        RecipeSelectionView(item: model.item, selectedRecipe: $selectedRecipe)
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

class Production {
    let item: Item
    let recipe: Recipe
    var amount: Double
    
    @Published var productionChain = [RecipeProductionNode]()
    
    init(item: Item, recipe: Recipe, amount: Double) {
        self.item = item
        self.recipe = recipe
        self.amount = amount
        
        productionChain.append(.init(item: item, recipe: recipe, amount: amount))
    }
    
    func add(recipe: Recipe, for item: Item, productionChainID: UUID) {
        guard let node = productionChain.first(where: { $0.id == productionChainID }) else { return }
        
        if let itemNode = productionChain.first(where: { node.nextNodeIDs.contains($0.id) }) {
            itemNode.recipe = recipe
            
            var remainingNodes = itemNode.nextNodeIDs
            while !remainingNodes.isEmpty {
                remainingNodes.forEach { node in
                    if let index = productionChain.firstIndex(where: { $0.id == node }) {
                        remainingNodes.append(contentsOf: productionChain[index].nextNodeIDs)
                        productionChain.remove(at: index)
                    }
                }
            }
        } else {
            let newNode = RecipeProductionNode(item: item, recipe: recipe, amount: 1)
            productionChain.append(newNode)
            node.nextNodeIDs.append(newNode.id)
        }
    }
}

class RecipeProductionNode: Identifiable, ObservableObject {
    let id = UUID()
    let item: Item
    var recipe: Recipe
    var amount: Double
    
    var nextNodeIDs = [UUID]()
    
    init(item: Item, recipe: Recipe, amount: Double) {
        self.item = item
        self.recipe = recipe
        self.amount = amount
    }
}

class RecipeTreeNode: Identifiable, ObservableObject {
    let id = UUID()
    let item: Item
    let recipe: Recipe
    var amount: Double {
        didSet {
            objectWillChange.send()
            
            Self.recalculateRecipes(recipeTree: self)
        }
    }
    
    var numberOfMachines: Double {
        guard let output = recipe.output.first(where: { $0.item.id == item.id }) else { return 1 }
        
        return amount / output.amountPerMinute
    }
    
    @Published var nextRecipeNodes = [RecipeTreeNode]()
    
    var allNodes: [RecipeTreeNode] {
        Self.allNodes(node: self)
    }
    
    var statistics: [CalculationStatisticsModel] {
        [.init(item: item, amount: amount)] + allNodes.reduce(into: []) { partialResult, node in
            for input in node.recipe.input {
                if let index = partialResult.firstIndex(where: { $0.item.id == input.item.id }) {
                    partialResult[index].amount += node.amount(for: input.item)
                } else {
                    partialResult.append(.init(item: input.item, amount: node.amount(for: input.item)))
                }
            }
        }
    }
    
    var machineStatistics: [CalculationMachineStatisticsModel] {
        let machinesByRecipes = allNodes.reduce(into: [CalculationMachineStatisticsModel]()) { partialResult, node in
            if let index = partialResult.firstIndex(where: { $0.item.id == node.item.id }), partialResult[index].recipe.id == node.recipe.id {
                partialResult[index].amount += node.numberOfMachines
            } else {
                partialResult.append(.init(recipe: node.recipe, item: node.item, amount: node.numberOfMachines))
            }
        }
        
        return machinesByRecipes.reduce(into: [CalculationMachineStatisticsModel]()) { partialResult, statisticsModel in
            if let index = partialResult.firstIndex(where: { $0.machine.id == statisticsModel.machine.id }) {
                partialResult[index].amount += ceil(statisticsModel.amount)
            } else {
                partialResult.append(.init(recipe: statisticsModel.recipe, item: statisticsModel.item, amount: ceil(statisticsModel.amount)))
            }
        }
    }
    
    init(item: Item, recipe: Recipe, amount: Double) {
        self.item = item
        self.recipe = recipe
        self.amount = amount
    }
    
    func amount(for inputItem: Item) -> Double {
        guard let output = recipe.output.first(where: { $0.item.id == item.id }) else { return 0 }
        guard let input = recipe.input.first(where: { $0.item.id == inputItem.id }) else { return 0 }

        let multiplier = amount / output.amountPerMinute
        return input.amountPerMinute * multiplier
    }
    
    func add(recipe: Recipe, for item: Item, at nodeID: UUID) {
        objectWillChange.send()
        
        Self.add(recipeTree: self, recipe: recipe, for: item, at: nodeID)
        
        checkInput(for: recipe)
    }
    
    func add(recipe: Recipe, for item: Item) {
        objectWillChange.send()
        
        Self.add(recipeTree: self, recipe: recipe, for: item)
        
        checkInput(for: recipe)
    }
    
    func addRemaining(recipe: Recipe, for item: Item) {
        objectWillChange.send()
        
        Self.addRemaining(recipeTree: self, recipe: recipe, for: item)
        
        checkInput(for: recipe)
    }
    
    func checkInput(for recipe: Recipe) {
//        for input in recipe.input {
//            guard (input.item as? Part)?.rawResource == false else { continue }
//
//            let recipeCount = input.item.recipes.count
//            let favoriteCount = input.item.recipes.filter(\.isFavorite).count
//
//            if recipeCount == 1 {
//                add(recipe: input.item.recipes[0], for: input.item)
//            } else if favoriteCount == 1 {
//                add(recipe: input.item.recipes.filter(\.isFavorite)[0], for: input.item)
//            }
//        }
    }
    
    func hasRecipe(for item: Item) -> Bool {
        nextRecipeNodes.contains(where: { $0.item.id == item.id }) || (item as? Part)?.rawResource == true
    }
    
    func hasMultiple(of item: Item) -> Bool {
        allNodes
            .reduce([]) { partialResult, node in
                partialResult + node.recipe.input.map(\.item)
            }
            .filter { $0.id == item.id }
            .count > 1
    }
    
    private static func allNodes(node: RecipeTreeNode) -> [RecipeTreeNode] {
        var result = [RecipeTreeNode]()
        var queue = [RecipeTreeNode]()
        
        queue.append(node)
        
        while !queue.isEmpty {
            let queueSize = queue.count
            
            for _ in 0..<queueSize {
                let current = queue.removeFirst()
                result.append(current)
                
                queue.append(contentsOf: current.nextRecipeNodes)
            }
        }
        
        return result
    }
    
    private static func add(recipeTree: RecipeTreeNode, recipe: Recipe, for item: Item, at nodeID: UUID) {
        if recipeTree.id == nodeID {
            if let index = recipeTree.nextRecipeNodes.firstIndex(where: { $0.item.id == item.id }) {
                recipeTree.nextRecipeNodes.remove(at: index)
            }
            
            let amount = recipeTree.amount(for: item)
            recipeTree.nextRecipeNodes.append(.init(item: item, recipe: recipe, amount: amount))
        } else {
            recipeTree.nextRecipeNodes.forEach { Self.add(recipeTree: $0, recipe: recipe, for: item, at: nodeID) }
        }
    }
    
    private static func add(recipeTree: RecipeTreeNode, recipe: Recipe, for item: Item) {
        if recipeTree.recipe.input.contains(where: { $0.item.id == item.id }) {
            if let index = recipeTree.nextRecipeNodes.firstIndex(where: { $0.item.id == item.id }) {
                recipeTree.nextRecipeNodes.remove(at: index)
            }
            
            let amount = recipeTree.amount(for: item)
            recipeTree.nextRecipeNodes.append(.init(item: item, recipe: recipe, amount: amount))
        }
        
        recipeTree.nextRecipeNodes.forEach { Self.add(recipeTree: $0, recipe: recipe, for: item) }
    }
    
    private static func addRemaining(recipeTree: RecipeTreeNode, recipe: Recipe, for item: Item) {
        if recipeTree.recipe.input.contains(where: { $0.item.id == item.id }) {
            if let index = recipeTree.nextRecipeNodes.firstIndex(where: { $0.item.id == item.id }),
               recipeTree.nextRecipeNodes[index].nextRecipeNodes.isEmpty {
                recipeTree.nextRecipeNodes.remove(at: index)
            }
            
            let amount = recipeTree.amount(for: item)
            recipeTree.nextRecipeNodes.append(.init(item: item, recipe: recipe, amount: amount))
        }
        
        recipeTree.nextRecipeNodes.forEach { Self.add(recipeTree: $0, recipe: recipe, for: item) }
    }
    
    private static func recalculateRecipes(recipeTree: RecipeTreeNode) {
        print("recalculateRecipes called")
        for node in recipeTree.nextRecipeNodes {
            node.amount = recipeTree.amount(for: node.item)
            
            recalculateRecipes(recipeTree: node)
        }
    }
}

extension RecipeTreeNode: CustomStringConvertible {
    var description: String {
        """
        Item: \(item.name)
        Amount: \(amount.formatted(.fractionFromZeroToFour))
        Recipe: \(String(describing: recipe))

        \(nextRecipeNodes.map(\.description).joined(separator: "\n"))
        """
    }
}
