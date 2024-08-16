import Foundation

public enum Production: Identifiable, Hashable, Sendable {
    case singleItem(SingleItemProduction)
    
    public var id: UUID {
        switch self {
        case let .singleItem(production): production.id
        }
    }
    
    public var name: String {
        get {
            switch self {
            case let .singleItem(production): production.name
            }
        }
        set {
            switch self {
            case let .singleItem(production):
                var copy = production
                copy.name = newValue
                self = .singleItem(copy)
            }
        }
    }
    
    public var asset: Asset {
        get {
            switch self {
            case let .singleItem(production): .assetCatalog(name: production.item.id)
            }
        }
        set {
            switch self {
            case .singleItem: break // Single item production asset cannot be changed.
            }
        }
    }
}
