import Foundation

public struct PersistentProductionLegacy: Decodable {
    public let productionTreeRootID: String
    public let amount: Double
    public let productionChain: [Chain]
    
    public var root: Chain? {
        productionChain.first { $0.id == productionTreeRootID }
    }
    
    public init(productionTreeRootID: String, amount: Double, productionChain: [Chain]) {
        self.productionTreeRootID = productionTreeRootID
        self.amount = amount
        self.productionChain = productionChain
    }
}

public extension PersistentProductionLegacy {
    struct Chain: Decodable {
        public let id: String
        public let itemID: String
        public let recipeID: String
        public let children: [String]
        
        public init(id: String, itemID: String, recipeID: String, children: [String]) {
            self.id = id
            self.itemID = itemID
            self.recipeID = recipeID
            self.children = children
        }
    }
}
