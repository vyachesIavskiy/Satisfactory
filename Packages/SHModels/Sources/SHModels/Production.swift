import Foundation

// MARK: Model

public struct Production: Identifiable, Hashable, Sendable {
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
    
    public static func == (lhs: Production, rhs: Production) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.item.id == rhs.item.id && lhs.amount == rhs.amount
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

extension Production {
    public struct InputItem: Hashable, Sendable {
        public var item: any Item
        public var recipes: [InputRecipe]
        
        public init(item: any Item, recipes: [InputRecipe]) {
            self.item = item
            self.recipes = recipes
        }
        
        public static func == (lhs: Production.InputItem, rhs: Production.InputItem) -> Bool {
            lhs.item.id == rhs.item.id &&
            lhs.recipes == rhs.recipes
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(item.id)
            hasher.combine(recipes)
        }
    }
}

extension Production {
    public struct InputRecipe: Hashable, Sendable {
        public var recipe: Recipe
        public var proportion: SHProductionProportion
        
        public init(recipe: Recipe, proportion: SHProductionProportion) {
            self.recipe = recipe
            self.proportion = proportion
        }
    }
}

extension Production {
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

extension Production {
    public struct InputByproductProducer: Hashable, Sendable {
        public var recipe: Recipe
        public var consumers: [Recipe]
        
        public init(recipe: Recipe, consumers: [Recipe]) {
            self.recipe = recipe
            self.consumers = consumers
        }
    }
}

public extension Collection where Element == Production {
    func first(id: UUID) -> Element?  {
        first { $0.id == id }
    }
    
    func firstIndex(id: UUID) -> Index? {
        firstIndex { $0.id == id }
    }
}

// MARK: Legacy

extension Production.Persistent {
    struct Legacy: Decodable {
        struct Chain: Decodable {
            let id: String
            let itemID: String
            let recipeID: String
            let children: [String]
        }
        
        let productionTreeRootID: String
        let amount: Double
        let productionChain: [Chain]
        
        var root: Chain? {
            productionChain.first { $0.id == productionTreeRootID }
        }
    }
}

// MARK: Persistent

extension Production {
    enum Persistent {}
}
