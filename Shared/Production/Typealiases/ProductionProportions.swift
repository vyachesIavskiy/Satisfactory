import SHModels

typealias ProductionProportions = [String: ProductionProportion]

extension ProductionProportions {
    init(recipe: Recipe) {
        self = [recipe.id: .default]
    }
    
    mutating func set(_ proportion: ProductionProportion, for recipe: Recipe) {
        self[recipe.id] = proportion
    }
    
    mutating func remove(for recipes: [Recipe]) {
        recipes.forEach { remove(for: $0) }
    }
    
    mutating func remove(for recipe: Recipe) {
        self[recipe.id] = nil
    }
}
