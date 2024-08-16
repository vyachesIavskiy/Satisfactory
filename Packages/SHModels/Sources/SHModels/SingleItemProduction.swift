import Foundation

// MARK: Model

public struct SingleItemProduction: Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var item: any Item
    public var amount: Double
    public var inputItems: [InputItem]
    public var byproducts: [InputByproduct]
    
    public init(
        id: UUID,
        name: String,
        item: some Item,
        amount: Double,
        inputItems: [InputItem],
        byproducts: [InputByproduct]
    ) {
        self.id = id
        self.name = name
        self.item = item
        self.amount = amount
        self.inputItems = inputItems
        self.byproducts = byproducts
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.item.id == rhs.item.id &&
        lhs.amount == rhs.amount &&
        lhs.inputItems == rhs.inputItems &&
        lhs.byproducts == rhs.byproducts
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(item.id)
        hasher.combine(amount)
        hasher.combine(inputItems)
        hasher.combine(byproducts)
    }
}

extension SingleItemProduction {
    public struct InputItem: Hashable, Sendable {
        public var item: any Item
        public var recipes: [InputRecipe]
        
        public init(item: any Item, recipes: [InputRecipe]) {
            self.item = item
            self.recipes = recipes
        }
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.item.id == rhs.item.id &&
            lhs.recipes == rhs.recipes
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(item.id)
            hasher.combine(recipes)
        }
    }
}

extension SingleItemProduction {
    public struct InputRecipe: Hashable, Sendable {
        public var recipe: Recipe
        public var proportion: SHProductionProportion
        
        public init(recipe: Recipe, proportion: SHProductionProportion) {
            self.recipe = recipe
            self.proportion = proportion
        }
    }
}

extension SingleItemProduction {
    public struct InputByproduct: Hashable, Sendable {
        public var item: any Item
        public var producers: [InputByproductProducer]
        
        public init(item: any Item, producers: [InputByproductProducer]) {
            self.item = item
            self.producers = producers
        }
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.item.id == rhs.item.id &&
            lhs.producers == rhs.producers
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(item.id)
            hasher.combine(producers)
        }
    }
}

extension SingleItemProduction {
    public struct InputByproductProducer: Hashable, Sendable {
        public var recipe: Recipe
        public var consumers: [Recipe]
        
        public init(recipe: Recipe, consumers: [Recipe]) {
            self.recipe = recipe
            self.consumers = consumers
        }
    }
}

public extension Sequence<SingleItemProduction> {
    func first(id: UUID) -> Element?  {
        first { $0.id == id }
    }
}

public extension Collection<SingleItemProduction> {
    func firstIndex(id: UUID) -> Index? {
        firstIndex { $0.id == id }
    }
}
