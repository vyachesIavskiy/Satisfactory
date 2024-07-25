import Foundation
import SHModels

extension SingleItemProduction {
    public struct UserInput {
        /// A final product produced by calculation.
        public let item: any Item
        
        /// Target amount of final product. All other products will be calculated based on this number.
        public var amount: Double
        
        /// Final and intermediate products with corresponding recipes, selected to produce the final product.
        public var products: [Product]
        
        /// A separate byproduct relation between different products.
        public var byproducts: [Byproduct]
        
        public init(item: any Item, amount: Double, products: [Product] = [], byproducts: [Byproduct] = []) {
            self.item = item
            self.amount = amount
            self.products = products
            self.byproducts = byproducts
        }
        
        public mutating func addProduct(_ product: Product) {
            guard !products.contains(where: { $0.item.id != product.item.id }) else { return }
            
            products.append(product)
        }
        
        public mutating func updateProduct(_ product: Product) {
            guard let index = products.firstIndex(where: { $0.item.id == product.item.id }) else {
                return
            }
            
            products[index] = product
        }
        
        public mutating func addProductRecipe(_ productRecipe: ProductRecipe, to item: any Item) {
            guard let index = products.firstIndex(where: { $0.item.id == item.id }) else {
                products.append(Product(item: item, recipes: [productRecipe]))
                return
            }
            
            products[index].addProductRecipe(productRecipe)
        }
        
        public mutating func addRecipe(_ recipe: Recipe, with proportion: SHProductionProportion, to item: any Item) {
            addProductRecipe(ProductRecipe(recipe: recipe, proportion: proportion), to: item)
        }
        
        public mutating func removeProduct(with item: any Item) {
            guard item.id != self.item.id else {
                // Final product cannot be removed from calculation
                return
            }
            
            guard let index = products.firstIndex(where: { $0.item.id == item.id }) else {
                return
            }
            
            products.remove(at: index)
        }
        
        public mutating func removeRecipe(_ recipe: Recipe, from product: any Item) {
            guard
                let productIndex = products.firstIndex(where: { $0.item.id == product.id }),
                let recipeIndex = products[productIndex].recipes.firstIndex(where: { $0.recipe == recipe })
            else { return }
            
            products[productIndex].recipes.remove(at: recipeIndex)
        }
        
        public mutating func changeProportion(
            of recipe: Recipe,
            for item: any Item,
            to newProportion: SHProductionProportion
        ) {
            guard
                let productIndex = products.firstIndex(where: { $0.item.id == item.id }),
                let recipeIndex = products[productIndex].recipes.firstIndex(where: { $0.recipe == recipe })
            else { return }
            
            products[productIndex].recipes[recipeIndex].proportion = newProportion
        }
        
        public mutating func moveProducts(from offsets: IndexSet, to offset: Int) {
            guard products.indices.contains(offset) else { return }
            
            products.move(fromOffsets: offsets, toOffset: offset)
        }
        
        public mutating func addByproduct(_ item: any Item, producer: Recipe, consumer: Recipe) {
            guard let byproductIndex = byproducts.firstIndex(where: { $0.item.id == item.id }) else {
                byproducts.append(Byproduct(item: item, producer: producer, consumer: consumer))
                return
            }
            
            guard let producingIndex = byproducts[byproductIndex].producers.firstIndex(where: { $0.recipe == producer }) else {
                byproducts[byproductIndex].producers.append(Byproduct.Producer(producer, consumer: consumer))
                return
            }
            
            guard !byproducts[byproductIndex].producers[producingIndex].consumers.contains(consumer) else {
                return
            }
            
            // TODO: Need to check adding duplicate recipes. This might happen if same recipe is used to produce two different items.
            byproducts[byproductIndex].producers[producingIndex].consumers.append(consumer)
        }
        
        public mutating func removeByrpoduct(_ item: any Item) {
            guard let byproductIndex = byproducts.firstIndex(where: { $0.item.id == item.id }) else {
                return
            }
            
            byproducts.remove(at: byproductIndex)
        }
        
        public mutating func removeProducer(_ recipe: Recipe, for item: any Item) {
            guard
                let byproductIndex = byproducts.firstIndex(where: { $0.item.id == item.id }),
                let producingIndex = byproducts[byproductIndex].producers.firstIndex(where: { $0.recipe == recipe })
            else { return }
            
            byproducts[byproductIndex].producers.remove(at: producingIndex)
        }
        
        public mutating func removeConsumer(_ recipe: Recipe, for byproduct: any Item) {
            guard let byproductIndex = byproducts.firstIndex(where: { $0.item.id == byproduct.id }) else {
                return
            }
            
            // ConsumingRecipe can consume byproducts from more than one ProducingRecipe, need to check all ProducingRecipes.
            for (producingIndex, producingRecipe) in byproducts[byproductIndex].producers.enumerated() {
                guard let consumingIndex = producingRecipe.consumers.firstIndex(of: recipe) else { continue }
                
                byproducts[byproductIndex].producers[producingIndex].consumers.remove(at: consumingIndex)
            }
        }
    }
}

// MARK: Product
extension SingleItemProduction.UserInput {
    public struct Product {
        /// A product used in Product Calculator.
        public let item: any Item
        
        /// Recipes for selected product with corresponding proportions.
        public var recipes: [SingleItemProduction.UserInput.ProductRecipe]
        
        public mutating func addProductRecipe(_ recipe: SingleItemProduction.UserInput.ProductRecipe) {
            guard !recipes.contains(where: { $0.recipe == recipe.recipe }) else { return }
            
            recipes.append(recipe)
        }
    }
}

// MARK: ProductRecipe
extension SingleItemProduction.UserInput {
    public struct ProductRecipe {
        /// A recipe used to produce product.
        public let recipe: Recipe
        
        /// A proportion of total amount of product.
        ///
        /// This is used when more than one recipe produce a single intermediate product.
        /// This can be also used to calculate final product.
        public var proportion: SHProductionProportion
    }
}

// MARK: Byproduct
extension SingleItemProduction.UserInput {
    public struct Byproduct {
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
}
