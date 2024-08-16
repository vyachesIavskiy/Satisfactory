import Foundation

public enum Production: Identifiable, Hashable, Sendable {
    case singleItem(SingleItemProduction)
    case fromResources(FromResourcesProduction)
    case power(PowerProduction)
    
    public var id: UUID {
        switch self {
        case let .singleItem(production): production.id
        case let .fromResources(production): production.id
        case let .power(production): production.id
        }
    }
    
    public var name: String {
        get {
            switch self {
            case let .singleItem(production): production.name
            case let .fromResources(production): production.name
            case let .power(production): production.name
            }
        }
        set {
            switch self {
            case let .singleItem(production):
                var copy = production
                copy.name = newValue
                self = .singleItem(copy)
                
            case let .fromResources(production):
                var copy = production
                copy.name = newValue
                self = .fromResources(copy)
                
            case let .power(production):
                var copy = production
                copy.name = newValue
                self = .power(copy)
            }
        }
    }
    
    public var canSelectAsset: Bool {
        switch self {
        case .singleItem: false
        case .fromResources, .power: true
        }
    }
    
    public var asset: Asset {
        get {
            switch self {
            case let .singleItem(production): .assetCatalog(name: production.item.id)
            case let .fromResources(production): production.asset
            case let .power(production): production.asset
            }
        }
        set {
            switch self {
            case .singleItem: break // Single item production asset cannot be changed.
                
            case let .fromResources(production):
                var copy = production
                copy.asset = newValue
                self = .fromResources(copy)
                
            case let .power(production):
                var copy = production
                copy.asset = newValue
                self = .power(copy)
            }
        }
    }
}
