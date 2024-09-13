import Foundation
import SHDependencies

extension FromResourcesProduction {
    public struct InputItem: Hashable, Sendable {
        public let id: UUID
        public let part: Part
        public let amount: Double
        
        public init(id: UUID, part: Part, amount: Double) {
            self.id = id
            self.part = part
            self.amount = amount
        }
    }
}

// MARK: Input item + Sequence
extension Sequence<FromResourcesProduction.InputItem> {
    public func first(part: Part) -> Element? {
        first { $0.part == part }
    }
    public func contains(part: Part) -> Bool {
        contains { $0.part == part }
    }
}

// MARK: Input item + Collection
extension Collection<FromResourcesProduction.InputItem> {
    public func firstIndex(part: Part) -> Index? {
        firstIndex { $0.part == part }
    }
}

