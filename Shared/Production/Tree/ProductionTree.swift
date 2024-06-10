import SHModels

typealias ProductionTree = BidirectionalTreeNode<ProductionRecipeEntry>

extension ProductionTree {
    convenience init(item: any Item, recipe: Recipe, amount: Double) {
        self.init(element: ProductionRecipeEntry(
            item: item,
            recipe: recipe,
            amounts: (amount, amount)
        ))
    }
    
    func add(item: any Item, recipe: Recipe, amounts: ProductionAmounts) {
        add(element: ProductionRecipeEntry(item: item, recipe: recipe, amounts: amounts))
    }
    
    func leaf(containsRecipe recipe: Recipe) -> Bool {
        leaf { $0.recipe == recipe }
    }
    
    func firstIndex(of recipe: Recipe) -> Int? {
        firstIndex { $0.recipe == recipe }
    }
    
    func first(of recipe: Recipe) -> ProductionTree? {
        first { $0.recipe == recipe }
    }
    
    func remove(item: some Item) {
        removeAll { $0.item.id == item.id }
    }
}
