import Foundation
import SHModels

extension Production.Content.SingleItem.Persistent {
    package struct Legacy: Decodable {
        package let productionTreeRootID: UUID
        package let amount: Double
        package let productionChain: [Chain]
        
        package var root: Chain? {
            productionChain.first { $0.id == productionTreeRootID }
        }
        
        package var name: String {
            guard let root else { return "" }
            
            return "\(root.partID)-\(root.recipeID)-\(amount.formatted(.number.precision(.fractionLength(0...4))))"
        }
        
        package init(productionTreeRootID: UUID, amount: Double, productionChain: [Chain]) {
            self.productionTreeRootID = productionTreeRootID
            self.amount = amount
            self.productionChain = productionChain
        }
    }
}

extension Production.Content.SingleItem.Persistent.Legacy {
    package struct Chain: Decodable {
        package let id: UUID
        package let partID: String
        package let recipeID: String
        package let children: [UUID]
        
        package init(id: UUID, partID: String, recipeID: String, children: [UUID]) {
            self.id = id
            self.partID = partID
            self.recipeID = recipeID
            self.children = children
        }
    }
}
