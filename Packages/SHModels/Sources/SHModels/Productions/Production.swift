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
    
    public var creationDate: Date {
        switch self {
        case let .singleItem(production): production.creationDate
        case let .fromResources(production): production.creationDate
        case let .power(production): /*production.creationDate*/ Date()
        }
    }
    
    public var canSelectAsset: Bool {
        switch self {
        case .singleItem: false
        case .fromResources, .power: true
        }
    }
    
    public var assetName: String {
        get {
            switch self {
            case let .singleItem(production): production.assetName
            case let .fromResources(production): production.assetName
            case let .power(production): production.assetName
            }
        }
        set {
            switch self {
            case .singleItem: break // Single item production asset cannot be changed.
                
            case let .fromResources(production):
                var copy = production
                copy.assetName = newValue
                self = .fromResources(copy)
                
            case let .power(production):
                var copy = production
                copy.assetName = newValue
                self = .power(copy)
            }
        }
    }
    
    public var statistics: Statistics {
        switch self {
        case let .singleItem(production): production.statistics
        case let .fromResources(production): production.statistics
        case let .power(production): production.statistics
        }
    }
}

// MARK: Production + Sequence
public extension Sequence<Production> {
    func first(id: UUID) -> Element?  {
        first { $0.id == id }
    }
    
    func sortedByDate() -> [Production] {
        sorted(using: KeyPathComparator(\.creationDate, order: .reverse))
    }
    
    func sortedByName() -> [Production] {
        sorted(using: KeyPathComparator(\.name))
    }
}

// MARK: Production + Collection
public extension Collection<Production> {
    func firstIndex(id: UUID) -> Index? {
        firstIndex { $0.id == id }
    }
}
