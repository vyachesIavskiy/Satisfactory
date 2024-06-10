import SHModels

typealias ProductionByproducts = [ProductionByproduct]

struct ProductionByproduct {
    var item: any Item
    var produced: [Produced]
    var amountUsed: Double { produced.reduce(0) { $0 + $1.amountUsed } }
    
    init(item: some Item, fromRecipe: Recipe, toRecipe: Recipe) {
        self.item = item
        produced = [Produced(recipe: fromRecipe, required: toRecipe)]
    }
    
    init(item: some Item, produced: [Produced]) {
        self.item = item
        self.produced = produced
    }
    
    mutating func removeProducedIfNeeded(at index: Int) {
        if produced[index].required.isEmpty {
            produced.remove(at: index)
        }
    }
}

// MARK: - Produced
extension ProductionByproduct {
    struct Produced {
        var recipe: Recipe
        var amount = 0.0
        var amountUsed: Double { `required`.reduce(0) { $0 + $1.amount } }
        
        var required: [Required] {
            didSet {
                required.sort { $0.priority < $1.priority }
            }
        }
        
        init(recipe: Recipe, required: Recipe) {
            self.recipe = recipe
            self.required = [Required(recipe: required)]
        }
        
        init(recipe: Recipe, amount: Double, required: [Required]) {
            self.recipe = recipe
            self.amount = amount
            self.required = `required`
        }
    }
}

// MARK: - Required
extension ProductionByproduct.Produced {
    struct Required {
        var recipe: Recipe
        var amount = 0.0
        var priority = 0
    }
}

// MARK: - ProductionByproduct | Array
extension Array<ProductionByproduct> {
    func first(of item: some Item) -> Element? {
        first { $0.item.id == item.id }
    }
    
    func firstIndex(of item: some Item) -> Index? {
        firstIndex { $0.item.id == item.id }
    }
    
    func contains(_ item: some Item) -> Bool {
        contains { $0.item.id == item.id }
    }
}

// MARK: - Produced | Array
extension Array<ProductionByproduct.Produced> {
    func first(of recipe: Recipe) -> Element? {
        first { $0.recipe == recipe }
    }
    
    func firstIndex(of recipe: Recipe) -> Index? {
        firstIndex { $0.recipe == recipe }
    }
    
    func contains(_ recipe: Recipe) -> Bool {
        contains { $0.recipe == recipe }
    }
}

// MARK: - Required | Array
extension Array<ProductionByproduct.Produced.Required> {
    func first(of recipe: Recipe) -> Element? {
        first { $0.recipe == recipe }
    }
    
    func firstIndex(of recipe: Recipe) -> Index? {
        firstIndex { $0.recipe == recipe }
    }
    
    func contains(_ recipe: Recipe) -> Bool {
        contains { $0.recipe == recipe }
    }
}
