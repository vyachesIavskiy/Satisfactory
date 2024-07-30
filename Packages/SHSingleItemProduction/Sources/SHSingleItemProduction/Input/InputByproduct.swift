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

// MARK: Hashable
extension SHSingleItemProduction.InputByproduct: Hashable {
    public static func == (lhs: SHSingleItemProduction.InputByproduct, rhs: SHSingleItemProduction.InputByproduct) -> Bool {
        lhs.item.id == rhs.item.id &&
        lhs.producers == rhs.producers
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(item.id)
        hasher.combine(producers)
    }
}

extension SHSingleItemProduction.InputByproduct {
    public struct Producer: Hashable {
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
