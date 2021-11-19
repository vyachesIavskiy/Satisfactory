import Foundation

struct ProductionPersistent {
    var productionTreeRootID: String
    var amount: Double
    var productionChain: [ProductionTreePersistent]
    
    var rootNode: ProductionTreePersistent? {
        productionChain.first(where: { $0.id == productionTreeRootID })
    }
}

extension ProductionPersistent: PersistentStoragable {
    static var domain: String { "Productions" }
    var filename: String {
        guard let rootNode = rootNode else { return "" }
        return "\(rootNode.itemID)-\(rootNode.recipeID)-\(amount.formatted(.fractionFromZeroToFour))"
    }
}

struct ProductionTreePersistent: Codable {
    var id: String
    var itemID: String
    var recipeID: String
    var children: [String]
}
