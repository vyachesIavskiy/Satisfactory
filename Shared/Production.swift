import Foundation

// MARK: - Recipe Tree
typealias RecipeTree = Tree<RecipeElement>

extension RecipeTree {
    init(item: Item, recipe: Recipe, amount: Double) {
        self.init(element: RecipeElement(item: item, recipe: recipe, amount: amount))
    }
}

// MARK: - Production
final class Production: ObservableObject {
    var productionTree: RecipeTree
    var storage: BaseStorage!
    var item: Item
    var recipe: Recipe
    
    var amount: Double {
        didSet {
            recalculate()
        }
    }
    
    init(item: Item, recipe: Recipe, amount: Double) {
        productionTree = RecipeTree(item: item, recipe: recipe, amount: amount)
        self.amount = amount
        self.item = item
        self.recipe = recipe
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
            if let index = partialResult.firstIndex(where: { $0.item.id == tree.element.item.id }), partialResult[index].recipe.id == tree.element.recipe.id {
                partialResult[index].amount += Double(tree.element.numberOfMachines)
            } else {
                partialResult.append(.init(recipe: tree.element.recipe, item: tree.element.item, amount: Double(tree.element.numberOfMachines)))
            }
        }
        .reduce(into: []) { partialResult, statisticsModel in
            if let index = partialResult.firstIndex(where: { $0.machine.id == statisticsModel.machine.id }) {
                partialResult[index].amount += ceil(statisticsModel.amount)
            } else {
                partialResult.append(.init(recipe: statisticsModel.recipe, item: statisticsModel.item, amount: ceil(statisticsModel.amount)))
            }
        }
    }
    
    func checkInput(for recipe: Recipe) {
        for input in recipe.input where (input.item as? Part)?.rawResource == false {
            let recipes = storage[recipesFor: input.item.id]
            let favoriteRecipes = recipes.filter(\.isFavorite)
            
            if recipes.count == 1 {
                add(recipe: recipes[0], for: input.item)
            } else if favoriteRecipes.count == 1 {
                add(recipe: favoriteRecipes[0], for: input.item)
            }
        }
    }
    
    func add(recipe: Recipe, for item: Item, at branch: Tree<RecipeElement>) {
        objectWillChange.send()
        
        productionTree.apply { tree in
            tree.element.id == branch.element.id
        } transform: { tree in
            tree.removeChild(where: { $0.element.item.id == item.id })
            
            tree.add(child: RecipeTree(item: item, recipe: recipe, amount: tree.element.amount(for: item)))
        }
        
        checkInput(for: recipe)
    }
    
    func add(recipe: Recipe, for item: Item) {
        objectWillChange.send()
        
        productionTree.apply { tree in
            tree.element.recipe.input.contains { $0.item.id == item.id }
        } transform: { tree in
            tree.removeChild(where: { $0.element.item.id == item.id })
            
            tree.add(child: RecipeTree(item: item, recipe: recipe, amount: tree.element.amount(for: item)))
        }
        
        checkInput(for: recipe)
    }
    
    func addRemaining(recipe: Recipe, for item: Item) {
        objectWillChange.send()
        
        productionTree.apply { tree in
            guard tree.element.recipe.input.contains(where: { $0.item.id == item.id }),
                  let index = tree.children.firstIndex(where: { $0.element.item.id == item.id }),
                  tree.children[index].children.isEmpty else { return false }
            
            return true
        } transform: { tree in
            tree.removeChild(where: { $0.element.item.id == item.id })
            
            tree.add(child: RecipeTree(item: item, recipe: recipe, amount: tree.element.amount(for: item)))
        }
        
        checkInput(for: recipe)
    }
    
    func hasRecipe(for item: Item) -> Bool {
        productionTree.children.contains { tree in
            tree.element.item.id == item.id
        } || (item as? Part)?.rawResource == true
    }
    
    func hasMultiple(of item: Item) -> Bool {
        productionTree.reduce(strategy: .depth, []) { partialResult, tree in
            partialResult + tree.element.recipe.input.map(\.item)
        }
        .filter { $0.id == item.id }
        .count > 1
    }
    
    private func recalculate() {
        objectWillChange.send()
        
        productionTree.element.amount = amount
        
        productionTree.apply { tree in
            tree.children.enumerated().forEach { (index, child) in
                tree.children[index].element.amount = tree.element.amount(for: child.element.item)
            }
        }
    }
}
