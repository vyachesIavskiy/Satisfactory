
public struct Statistics: Hashable, Sendable {
    public var parts: [StatisticPart]
    public var naturalResources: [StatisticNaturalResource]
    
    public init(parts: [StatisticPart] = [], naturalResources: [StatisticNaturalResource] = []) {
        self.parts = parts
        self.naturalResources = naturalResources
    }
}

public struct StatisticPart: Identifiable, Hashable, Sendable {
    public var part: Part
    public var recipes: [StatisticRecipe]
    
    public var id: String { part.id }
    
    public var amount: Double {
        recipes.reduce(0) { $0 + $1.amount }
    }
    
    public init(part: Part, recipes: [StatisticRecipe]) {
        self.part = part
        self.recipes = recipes
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
    public var part: Part
    public var amount: Double
    
    public var id: String { part.id }
    
    public init(part: Part, amount: Double) {
        self.part = part
        self.amount = amount
    }
}
