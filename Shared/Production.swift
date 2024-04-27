import Foundation

// MARK: - Recipe Tree
typealias RecipeTree = Tree<RecipeElement>

extension RecipeTree {
    init(id: UUID = UUID(), item: Item, recipe: Recipe, amount: Double) {
        self.init(element: RecipeElement(id: id, item: item, recipe: recipe, amount: amount))
    }
}

extension RecipeTree: CustomStringConvertible {
    var description: String {
        description(with: "")
    }
    
    private func description(with prefix: String) -> String {
        """
        
        \(prefix)Item: \(element.item.name)
        \(prefix)Recipe: \(element.recipe.name)
        \(prefix)Amount: \(element.amount.formatted(.fractionFromZeroToFour))
        
        """
        +
        children.map { $0.description(with: "\(prefix)\t") }.joined()
    }
}

struct ProductionChain {
    fileprivate(set) var productionTree: RecipeTree
    
    var id: String {
        "\(item.id)-\(recipe.id)-\(amount.formatted(.fractionFromZeroToFour))"
    }
    
    var name: String
    
    var factoryID: UUID?
    
    var item: Item {
        productionTree.element.item
    }
    
    var recipe: Recipe {
        productionTree.element.recipe
    }
    
    var amount: Double {
        get {
            productionTree.element.amount
        }
        set {
            productionTree.element.amount = newValue
        }
    }
    
    init(item: Item, recipe: Recipe, amount: Double) {
        productionTree = RecipeTree(item: item, recipe: recipe, amount: amount)
        name = item.name
    }
    
    init(productionTree: RecipeTree) {
        self.productionTree = productionTree
        name = productionTree.element.item.name
        recalculate()
    }
    
    var statistics: [CalculationStatisticsModel] {
        [.init(item: item, amount: amount)] + productionTree.reduce(strategy: .depth, into: []) { partialResult, tree in
            for input in tree.element.recipe.input {
                if let index = partialResult.firstIndex(where: { $0.item.id == input.item.id }) {
                    partialResult[index].amount += tree.element.amount(for: input.item)
                } else {
                    partialResult.append(.init(item: input.item, amount: tree.element.amount(for: input.item)))
                }
            }
        }
    }
    
    var machineStatistics: [CalculationMachineStatisticsModel] {
        productionTree.reduce(strategy: .depth, into: [CalculationMachineStatisticsModel]()) { partialResult, tree in
            if let index = partialResult.firstIndex(where: { $0.recipe.id == tree.element.recipe.id }) {
                partialResult[index].amountOfMachines += tree.element.numberOfMachines
                partialResult[index].amount += tree.element.amount
            } else {
                partialResult.append(
                    .init(
                        recipe: tree.element.recipe,
                        item: tree.element.item,
                        amount: tree.element.amount,
                        amountOfMachines: tree.element.numberOfMachines
                    )
                )
            }
        }
    }
    
    mutating func recalculate() {
        productionTree.element.amount = amount
        
        productionTree.apply { tree in
            tree.children.enumerated().forEach { (index, child) in
                tree.children[index].element.amount = tree.element.amount(for: child.element.item)
            }
        }
    }
}

extension ProductionChain: Identifiable {}
extension ProductionChain: Hashable {}

extension Sequence<ProductionChain> {
    func sortedByTiers() -> [ProductionChain] {
        sorted { lhs, rhs in
            guard let lhsPart = lhs.item as? Part,
                  let rhsPart = rhs.item as? Part else { return true }
            
            if lhsPart.tier < rhsPart.tier {
                return true
            } else if lhsPart.tier == rhsPart.tier {
                if lhsPart.milestone < rhsPart.milestone {
                    return true
                } else if lhsPart.milestone == rhsPart.milestone {
                    return lhsPart.sortingPriority < rhsPart.sortingPriority
                }
            }
            
            return false
        }
    }
}

// MARK: - Production
final class Production: ObservableObject {
    var productionChain: ProductionChain
    
    var productionChainArray: [RecipeTree] {
        productionChain.productionTree.arrayLevels
    }
    
    var storage: Storage!
    
    var item: Item {
        productionChain.item
    }
    
    var recipe: Recipe {
        productionChain.recipe
    }
    
    var amount: Double {
        get {
            productionChain.amount
        }
        set {
            productionChain.amount = newValue
            
            recalculate()
        }
    }
    
    init(item: Item, recipe: Recipe, amount: Double) {
        productionChain = ProductionChain(item: item, recipe: recipe, amount: amount)
        self.amount = amount
    }
    
    init(productionChain: ProductionChain) {
        self.productionChain = productionChain
    }
    
    var statistics: [CalculationStatisticsModel] {
        productionChain.statistics
    }
    
    var machineStatistics: [CalculationMachineStatisticsModel] {
        productionChain.machineStatistics
    }
    
    func checkInput(for recipe: Recipe) {
        for input in recipe.input where (input.item as? Part)?.rawResource == false {
            let recipes = storage[recipesFor: input.item.id]
            let pinnedRecipes = recipes.filter(\.isPinned)
            
            if recipes.count == 1 {
                add(recipe: recipes[0], for: input.item)
            } else if pinnedRecipes.count == 1 {
                add(recipe: pinnedRecipes[0], for: input.item)
            }
        }
    }
    
    func add(recipe: Recipe, for item: Item, at branch: Tree<RecipeElement>) {
        objectWillChange.send()
        
        productionChain.productionTree.apply { tree in
            tree.element.id == branch.element.id
        } transform: { tree in
            tree.removeChild(where: { $0.element.item.id == item.id })
            
            tree.add(child: RecipeTree(item: item, recipe: recipe, amount: tree.element.amount(for: item)))
        }
        
        checkInput(for: recipe)
    }
    
    func add(recipe: Recipe, for item: Item) {
        objectWillChange.send()
        
        productionChain.productionTree.apply { tree in
            tree.element.recipe.input.contains { $0.item.id == item.id }
        } transform: { tree in
            tree.removeChild(where: { $0.element.item.id == item.id })
            
            tree.add(child: RecipeTree(item: item, recipe: recipe, amount: tree.element.amount(for: item)))
        }
        
        checkInput(for: recipe)
    }
    
    func addRemaining(recipe: Recipe, for item: Item) {
        objectWillChange.send()
        
        productionChain.productionTree.apply { tree in
            guard tree.element.recipe.input.contains(where: { $0.item.id == item.id }) else { return false }
                  
            guard let index = tree.children.firstIndex(where: { $0.element.item.id == item.id }) else { return true }
            
            return tree.children[index].children.isEmpty
        } transform: { tree in
            tree.removeChild(where: { $0.element.item.id == item.id })
            
            tree.add(child: RecipeTree(item: item, recipe: recipe, amount: tree.element.amount(for: item)))
        }
        
        checkInput(for: recipe)
    }
    
    func hasRecipe(for item: Item) -> Bool {
        productionChain.productionTree.children.contains { tree in
            tree.element.item.id == item.id
        } || (item as? Part)?.rawResource == true
    }
    
    func hasMultiple(of item: Item) -> Bool {
        productionChain.productionTree.reduce(strategy: .depth, []) { partialResult, tree in
            partialResult + tree.element.recipe.input.map(\.item)
        }
        .filter { $0.id == item.id }
        .count > 1
    }
    
    func save() {
        storage[productionChainID: productionChain.id] = productionChain
    }
    
    private func recalculate() {
        objectWillChange.send()
        
        productionChain.recalculate()
    }
}
