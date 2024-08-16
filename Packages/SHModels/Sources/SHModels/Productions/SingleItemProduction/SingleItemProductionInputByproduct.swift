import Foundation
import Dependencies

// MARK: Input byproduct
extension SingleItemProduction {
    public struct InputByproduct: Hashable, Sendable {
        public let id: UUID
        public var item: any Item
        public var producers: [InputByproductProducer]
        
        public init(id: UUID, item: some Item, producers: [InputByproductProducer]) {
            self.id = id
            self.item = item
            self.producers = producers
        }
        
        public init(id: UUID, item: some Item, producingRecipe: Recipe, consumingRecipe: Recipe) {
            @Dependency(\.uuid)
            var uuid
            
            self.init(
                id: id,
                item: item,
                producers: [
                    SingleItemProduction.InputByproductProducer(
                        id: uuid(),
                        producingRecipe: producingRecipe,
                        consumingRecipe: consumingRecipe
                    )
                ]
            )
        }
        
        // Equatable
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id &&
            lhs.item.id == rhs.item.id &&
            lhs.producers == rhs.producers
        }
        
        // Hashable
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(item.id)
            hasher.combine(producers)
        }
    }
}

// MARK: Input byproduct + Sequence
extension Sequence<SingleItemProduction.InputByproduct> {
    public func first(item: some Item) -> Element? {
        first { $0.item.id == item.id }
    }
}

// MARK: Input byproduct + Collection
extension Collection<SingleItemProduction.InputByproduct> {
    public func firstIndex(item: some Item) -> Index? {
        firstIndex { $0.item.id == item.id }
    }
}

// MARK: Input byproduct producer
extension SingleItemProduction {
    public struct InputByproductProducer: Hashable, Sendable {
        public let id: UUID
        public var recipe: Recipe
        public var consumers: [InputByproductConsumer]
        
        public init(id: UUID, recipe: Recipe, consumers: [InputByproductConsumer]) {
            self.id = id
            self.recipe = recipe
            self.consumers = consumers
        }
        
        public init(id: UUID, producingRecipe: Recipe, consumingRecipe: Recipe) {
            self.init(id: id, recipe: producingRecipe, consumers: [
                InputByproductConsumer(id: id, recipe: consumingRecipe)
            ])
        }
    }
}

// MARK: Input byproduct producer + Sequence
extension Sequence<SingleItemProduction.InputByproductProducer> {
    public func first(recipe: Recipe) -> Element? {
        first { $0.recipe == recipe }
    }
    
    public func contains(recipe: Recipe) -> Bool {
        contains { $0.recipe == recipe }
    }
}

// MARK: Input byproduct producer + Collection
extension Collection<SingleItemProduction.InputByproductProducer> {
    public func firstIndex(recipe: Recipe) -> Index? {
        firstIndex { $0.recipe == recipe }
    }
}

// MARK: Input byproduct consumer
extension SingleItemProduction {
    public struct InputByproductConsumer: Hashable, Sendable {
        public let id: UUID
        public var recipe: Recipe
        
        public init(id: UUID, recipe: Recipe) {
            self.id = id
            self.recipe = recipe
        }
    }
}

// MARK: Input byproduct consumer + Sequence
extension Sequence<SingleItemProduction.InputByproductConsumer> {
    public func first(recipe: Recipe) -> Element? {
        first { $0.recipe == recipe }
    }
    
    public func contains(recipe: Recipe) -> Bool {
        contains { $0.recipe == recipe }
    }
}

// MARK: Input byproduct consumer + Collection
extension Collection<SingleItemProduction.InputByproductConsumer> {
    public func firstIndex(recipe: Recipe) -> Index? {
        firstIndex { $0.recipe == recipe }
    }
}
