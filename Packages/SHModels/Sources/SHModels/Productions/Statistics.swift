
public struct Statistics: Hashable, Sendable {
    public var items: [StatisticItem]
    public var naturalResources: [StatisticNaturalResource]
    
    public init(items: [StatisticItem] = [], naturalResources: [StatisticNaturalResource] = []) {
        self.items = items
        self.naturalResources = naturalResources
    }
}

public struct StatisticItem: Identifiable, Hashable, Sendable {
    public var item: any Item
    public var recipes: [StatisticRecipe]
    
    public var id: String { item.id }
    
    public var amount: Double {
        recipes.reduce(0) { $0 + $1.amount }
    }
    
    public init(item: any Item, recipes: [StatisticRecipe]) {
        self.item = item
        self.recipes = recipes
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.recipes == rhs.recipes
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(recipes)
    }
}

public struct StatisticRecipe: Identifiable, Hashable, Sendable {
    public var recipe: Recipe
    public var amount: Double
    
    public var id: String { recipe.id }
    
    public init(recipe: Recipe, amount: Double) {
        self.recipe = recipe
        self.amount = amount
    }
}

public struct StatisticNaturalResource: Identifiable, Hashable, Sendable {
    public var item: any Item
    public var amount: Double
    
    public var id: String { item.id }
    
    public init(item: any Item, amount: Double) {
        self.item = item
        self.amount = amount
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.amount == rhs.amount
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(amount)
    }
}
