import Foundation
import SHDependencies

// MARK: Input byproduct
extension FromResourcesProduction {
    public struct InputByproduct: Hashable, Sendable {
        public let id: UUID
        public var part: Part
        public var producers: [InputByproductProducer]
        
        public init(id: UUID, part: Part, producers: [InputByproductProducer]) {
            self.id = id
            self.part = part
            self.producers = producers
        }
        
        public init(id: UUID, part: Part, producingRecipe: Recipe, consumingRecipe: Recipe) {
            @Dependency(\.uuid)
            var uuid
            
            self.init(
                id: id,
                part: part,
                producers: [
                    FromResourcesProduction.InputByproductProducer(
                        id: uuid(),
                        producingRecipe: producingRecipe,
                        consumingRecipe: consumingRecipe
                    )
                ]
            )
        }
    }
}

// MARK: Input byproduct + Sequence
extension Sequence<FromResourcesProduction.InputByproduct> {
    public func first(part: Part) -> Element? {
        first { $0.part == part }
    }
}

// MARK: Input byproduct + Collection
extension Collection<FromResourcesProduction.InputByproduct> {
    public func firstIndex(part: Part) -> Index? {
        firstIndex { $0.part == part }
    }
}

// MARK: Input byproduct producer
extension FromResourcesProduction {
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
extension Sequence<FromResourcesProduction.InputByproductProducer> {
    public func first(recipe: Recipe) -> Element? {
        first { $0.recipe == recipe }
    }
    
    public func contains(recipe: Recipe) -> Bool {
        contains { $0.recipe == recipe }
    }
}

// MARK: Input byproduct producer + Collection
extension Collection<FromResourcesProduction.InputByproductProducer> {
    public func firstIndex(recipe: Recipe) -> Index? {
        firstIndex { $0.recipe == recipe }
    }
}

// MARK: Input byproduct consumer
extension FromResourcesProduction {
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
extension Sequence<FromResourcesProduction.InputByproductConsumer> {
    public func first(recipe: Recipe) -> Element? {
        first { $0.recipe == recipe }
    }
    
    public func contains(recipe: Recipe) -> Bool {
        contains { $0.recipe == recipe }
    }
}

// MARK: Input byproduct consumer + Collection
extension Collection<FromResourcesProduction.InputByproductConsumer> {
    public func firstIndex(recipe: Recipe) -> Index? {
        firstIndex { $0.recipe == recipe }
    }
}
