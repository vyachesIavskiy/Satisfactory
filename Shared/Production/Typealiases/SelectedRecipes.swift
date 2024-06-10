import SHModels

typealias SelectedRecipes = [String: [Recipe]]

extension SelectedRecipes {
    init(item: some Item, recipe: Recipe) {
        self = [item.id: [recipe]]
    }
    
    mutating func add(recipe: Recipe, for item: some Item) {
        guard let recipes = self[item.id] else {
            self[item.id] = [recipe]
            return
        }
        
        if !recipes.contains(recipe) {
            self[item.id]?.append(recipe)
        }
    }
    
    @discardableResult
    mutating func remove(item: some Item) -> [Recipe] {
        let recipes = recipes(for: item)
        self[item.id] = nil
        return recipes
    }
    
    mutating func remove(_ recipe: Recipe) {
        for key in keys {
            if let recipeIndex = self[key]?.firstIndex(of: recipe) {
                self[key]?.remove(at: recipeIndex)
            }
        }
    }
    
    mutating func remove(_ recipe: Recipe, from item: some Item) {
        if let index = self[item.id]?.firstIndex(of: recipe) {
            self[item.id]?.remove(at: index)
        }
    }
    
    func recipes(for item: some Item) -> [Recipe] {
        self[item.id, default: []]
    }
    
    func recipes(forInput item: some Item) -> [Recipe] {
        recipes { $0.filter { $0.input.contains { $0.id == item.id } } }
    }
    
    func recipes(forByproduct item: some Item) -> [Recipe] {
        recipes { $0.filter { $0.byproducts.contains { $0.id == item.id } } }
    }
    
    func recipes(where predicate: (Value) -> [Recipe]) -> [Recipe] {
        flatMap { predicate($0.value) }
    }
    
    func item(_ item: some Item, contains recipe: Recipe) -> Bool {
        self[item.id]?.contains(recipe) == true
    }
}
