import SHModels

extension SingleItemProduction {
    struct Byproduct {
        let item: any Item
        let recipeID: String
        var amount: Double
        var consumers: [Consumer]
        
        var availableAmount: Double {
            amount - totalConsumingAmount
        }
        
        var totalConsumingAmount: Double {
            consumers.reduce(0.0) { $0 + $1.amount }
        }
        
        init(item: some Item, recipeID: String, amount: Double, consumers: [Consumer] = []) {
            self.item = item
            self.recipeID = recipeID
            self.amount = amount
            self.consumers = consumers
        }
        
        struct Consumer {
            let recipeID: String
            var amount: Double
        }
    }
}

extension Array<SingleItemProduction.Byproduct> {
    var balanced: Bool {
        // Byproducts are balanced when amount of produced byproduct is equal to amount of consumed byproduct.
        allSatisfy { $0.availableAmount.isZero }
    }
    
    mutating func merge(with other: [SingleItemProduction.Byproduct]) {
        merge(with: other) { lhs, rhs in
            lhs.recipeID == rhs.recipeID
        } merging: { lhs, rhs in
            lhs.amount += rhs.amount
            lhs.consumers.merge(with: rhs.consumers) { lhs, rhs in
                lhs.recipeID == rhs.recipeID
            } merging: { lhs, rhs in
                lhs.amount += rhs.amount
            }
        }
    }
}
