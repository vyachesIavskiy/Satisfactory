import Foundation
import SHModels
import SHStaticModels

extension Production.Persistent {
    public enum V2: Identifiable, Codable, Hashable {
        case singleItem(SingleItemProduction.Persistent.V2)
        case fromResources(FromResourcesProduction.Persistent.V2)
        case power(PowerProduction.Persistent.V2)
        
        enum CodingKeys: String, CodingKey {
            case productionType
        }
        
        public var id: UUID {
            switch self {
            case let .singleItem(production): production.id
            case let .fromResources(production): production.id
            case let .power(production): production.id
            }
        }
        
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let productionType = try container.decode(ProductionType.self, forKey: .productionType)
            
            switch productionType {
            case .singleItem:
                try self = .singleItem(SingleItemProduction.Persistent.V2(from: decoder))
                
            case .fromResources:
                try self = .fromResources(FromResourcesProduction.Persistent.V2(from: decoder))
                
            case .power:
                try self = .power(PowerProduction.Persistent.V2(from: decoder))
            }
        }
        
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            switch self {
            case let .singleItem(production):
                try production.encode(to: encoder)
                try container.encode(ProductionType.singleItem, forKey: .productionType)
                
            case let .fromResources(production):
                try production.encode(to: encoder)
                try container.encode(ProductionType.fromResources, forKey: .productionType)
                
            case let .power(production):
                try production.encode(to: encoder)
                try container.encode(ProductionType.power, forKey: .productionType)
            }
        }
        
        public mutating func migrate(migration: Migration) {
            switch self {
            case let .singleItem(production):
                var copy = production
                copy.migrate(migration)
                self = .singleItem(copy)
                
            case let .fromResources(production):
                var copy = production
                copy.migrate(migration)
                self = .fromResources(copy)
                
            case let .power(production):
                var copy = production
                copy.migrate(migration)
                self = .power(copy)
            }
        }
    }
}

enum ProductionType: String, Codable {
    case singleItem
    case fromResources
    case power
}
