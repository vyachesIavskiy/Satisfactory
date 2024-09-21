import Foundation
import SHDependencies

extension Production.Content {
    public struct FromResources: Hashable, Sendable {
        public var resources: [InputResource]
        public var inputItems: [InputItem]
        public var byproducts: [InputByproduct]
        public var statistics: Statistics
        
        public init(
            resources: [InputResource] = [],
            inputItems: [InputItem] = [],
            byproducts: [InputByproduct] = [],
            statistics: Statistics
        ) {
            self.resources = resources
            self.inputItems = inputItems
            self.byproducts = byproducts
            self.statistics = statistics
        }
        
        // Equatable
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.resources == rhs.resources &&
            lhs.inputItems == rhs.inputItems &&
            lhs.byproducts == rhs.byproducts &&
            lhs.statistics == rhs.statistics
        }
        
        // Hashable
        public func hash(into hasher: inout Hasher) {
            hasher.combine(resources)
            hasher.combine(inputItems)
            hasher.combine(byproducts)
            hasher.combine(statistics)
        }
    }
}
