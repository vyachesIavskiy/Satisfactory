import Foundation

struct ProductionPersistent {
    var name: String
    var factoryID: UUID?
    var productionTreeRootID: String
    var amount: Double
    var productionChain: [ProductionTreePersistent]
    
    var rootNode: ProductionTreePersistent? {
        productionChain.first(where: { $0.id == productionTreeRootID })
    }
    
    init(
        name: String,
        factoryID: UUID? = nil,
        productionTreeRootID: String,
        amount: Double,
        productionChain: [ProductionTreePersistent]
    ) {
        self.name = name
        self.factoryID = factoryID
        self.productionTreeRootID = productionTreeRootID
        self.amount = amount
        self.productionChain = productionChain
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        factoryID = try container.decodeIfPresent(UUID.self, forKey: .factoryID)
        productionTreeRootID = try container.decode(String.self, forKey: .productionTreeRootID)
        amount = try container.decode(Double.self, forKey: .amount)
        productionChain = try container.decode([ProductionTreePersistent].self, forKey: .productionChain)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}

extension ProductionPersistent: PersistentStoragable {
    static var domain: String { "Productions" }
    var filename: String {
        if !name.isEmpty {
            if let factoryID {
                "\(factoryID.uuidString)/\(name)"
            } else {
                name
            }
        } else if let rootNode {
            "\(rootNode.itemID)-\(rootNode.recipeID)-\(amount.formatted(.fractionFromZeroToFour))"
        } else {
            ""
        }
    }
}

struct ProductionTreePersistent: Codable {
    var id: String
    var itemID: String
    var recipeID: String
    var children: [String]
}
