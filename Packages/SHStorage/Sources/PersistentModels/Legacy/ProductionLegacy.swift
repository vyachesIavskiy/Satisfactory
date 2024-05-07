import Foundation
import Models

extension Production.Persistent {
    public struct Legacy: Decodable {
        public let productionTreeRootID: UUID
        public let amount: Double
        public let productionChain: [Chain]
        
        public var root: Chain? {
            productionChain.first { $0.id == productionTreeRootID }
        }
        
        public var name: String {
            guard let root else { return "" }
            
            return "\(root.itemID)-\(root.recipeID)-\(amount.formatted(.number.precision(.fractionLength(0...4))))"
        }
        
        public init(productionTreeRootID: UUID, amount: Double, productionChain: [Chain]) {
            self.productionTreeRootID = productionTreeRootID
            self.amount = amount
            self.productionChain = productionChain
        }
    }
}

extension Production.Persistent.Legacy {
    public struct Chain: Decodable {
        public let id: UUID
        public let itemID: String
        public let recipeID: String
        public let children: [UUID]
        
        public init(id: UUID, itemID: String, recipeID: String, children: [UUID]) {
            self.id = id
            self.itemID = itemID
            self.recipeID = recipeID
            self.children = children
        }
    }
}
