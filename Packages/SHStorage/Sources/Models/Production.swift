import Foundation

// MARK: Model

public struct Production: Equatable {
    public var id: UUID
    public var name: String
    public var item: any Item
    public var amount: Double
    // TODO: Declare production internal structure
    
    public init(id: UUID, name: String, item: some Item, amount: Double) {
        self.id = id
        self.name = name
        self.item = item
        self.amount = amount
    }
    
    public static func == (lhs: Production, rhs: Production) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.item.id == rhs.item.id && lhs.amount == rhs.amount
    }
}

public extension Collection where Element == Production {
    func first(id: UUID) -> Element?  {
        first { $0.id == id }
    }
    
    func firstIndex(id: UUID) -> Index? {
        firstIndex { $0.id == id }
    }
}

// MARK: Legacy

extension Production.Persistent {
    struct Legacy: Decodable {
        struct Chain: Decodable {
            let id: String
            let itemID: String
            let recipeID: String
            let children: [String]
        }
        
        let productionTreeRootID: String
        let amount: Double
        let productionChain: [Chain]
        
        var root: Chain? {
            productionChain.first { $0.id == productionTreeRootID }
        }
    }
}

// MARK: Persistent

extension Production {
    enum Persistent {}
}
