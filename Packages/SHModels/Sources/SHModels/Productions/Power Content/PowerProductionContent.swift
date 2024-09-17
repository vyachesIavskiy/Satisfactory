import Foundation

extension Production.Content {
    public struct Power: Hashable, Sendable {
        public var statistics: Statistics
        // TODO: Add fields
        
        public init(statistics: Statistics = Statistics()) {
            self.statistics = statistics
        }
    }
}
