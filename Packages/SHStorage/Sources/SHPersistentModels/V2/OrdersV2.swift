import Foundation

package struct OrdersV2: Codable, Hashable, Sendable {
    package var factoryOrder: [UUID]
    package var productionOrders: [ProductionOrder]
    
    package init(factoryOrder: [UUID] = [], productionOrders: [ProductionOrder] = []) {
        self.factoryOrder = factoryOrder
        self.productionOrders = productionOrders
    }
}

extension OrdersV2 {
    package struct ProductionOrder: Codable, Hashable, Sendable {
        package var factoryID: UUID
        package var order: [UUID]
        
        package init(factoryID: UUID, order: [UUID]) {
            self.factoryID = factoryID
            self.order = order
        }
    }
}

extension Sequence<OrdersV2.ProductionOrder> {
    package func first(factoryID: UUID) -> Element? {
        first { $0.factoryID == factoryID }
    }
}

extension Collection<OrdersV2.ProductionOrder> {
    package func firstIndex(factoryID: UUID) -> Index? {
        firstIndex { $0.factoryID == factoryID }
    }
}
