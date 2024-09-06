import Foundation
import SHDependencies

extension FromResourcesProduction {
    public struct InputItem: Hashable, Sendable {
        public let id: UUID
        public let item: any Item
        public let amount: Double
        
        @Dependency(\.uuid)
        private var uuid
        
        public init(id: UUID, item: any Item, amount: Double) {
            self.id = id
            self.item = item
            self.amount = amount
        }
        
        // Equatable
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id &&
            lhs.item.id == rhs.item.id &&
            lhs.amount == rhs.amount
        }
        
        // Hashable
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(item.id)
            hasher.combine(amount)
        }
    }
}

// MARK: Input item + Sequence
extension Sequence<FromResourcesProduction.InputItem> {
    public func first(item: any Item) -> Element? {
        first { $0.item.id == item.id }
    }
    public func contains(item: any Item) -> Bool {
        contains { $0.item.id == item.id }
    }
}

// MARK: Input item + Collection
extension Collection<FromResourcesProduction.InputItem> {
    public func firstIndex(item: any Item) -> Index? {
        firstIndex { $0.item.id == item.id }
    }
}

