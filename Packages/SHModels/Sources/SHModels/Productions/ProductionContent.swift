
extension Production {
    public enum Content: Hashable, Sendable {
        case singleItem(Production.Content.SingleItem)
        case fromResources(Production.Content.FromResources)
        case power(Production.Content.Power)
        
        public var canSelectAsset: Bool {
            switch self {
            case .singleItem: false
            case .fromResources, .power: true
            }
        }
        
        public var statistics: Statistics {
            switch self {
            case let .singleItem(content): content.statistics
            case let .fromResources(content): content.statistics
            case let .power(content): content.statistics
            }
        }
    }
}
