import SHModels

extension SHSingleItemProduction {
    public struct InputByproduct {
        /// A product which is registered as byproduct.
        public let item: any Item
        
        /// Recipes registered as producing current product as byproduct.
        public var producers: [Producer]
        
        public init(item: any Item, producers: [Producer]) {
            self.item = item
            self.producers = producers
        }
        
        public init(item: any Item, producer: Recipe, consumer: Recipe) {
            self.init(item: item, producers: [Producer(producer, consumer: consumer)])
        }
    }
}

extension SHSingleItemProduction.InputByproduct {
    public struct Producer {
        /// An actual recipe producing a byproduct.
        public let recipe: Recipe
        
        /// Recipes registered as consuming current product as byproduct.
        public var consumers: [Recipe]
        
        public init(recipe: Recipe, consumers: [Recipe]) {
            self.recipe = recipe
            self.consumers = consumers
        }
        
        public init(_ producer: Recipe, consumer: Recipe) {
            self.init(recipe: producer, consumers: [consumer])
        }
    }
}
