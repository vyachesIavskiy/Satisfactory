import Foundation
import SHModels
import SHStaticModels

extension Production.Content.Persistent {
    package enum V2: Codable, Hashable {
        case singleItem(Production.Content.SingleItem.Persistent.V2)
        case fromResources(Production.Content.FromResources.Persistent.V2)
        case power(Production.Content.Power.Persistent.V2)
        
        enum CodingKeys: String, CodingKey {
            case productionType
        }
        
        package init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let productionType = try container.decode(ProductionType.self, forKey: .productionType)
            
            switch productionType {
            case .singleItem:
                try self = .singleItem(Production.Content.SingleItem.Persistent.V2(from: decoder))
                
            case .fromResources:
                try self = .fromResources(Production.Content.FromResources.Persistent.V2(from: decoder))
                
            case .power:
                try self = .power(Production.Content.Power.Persistent.V2(from: decoder))
            }
        }
        
        package func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            switch self {
            case let .singleItem(content):
                try content.encode(to: encoder)
                try container.encode(ProductionType.singleItem, forKey: .productionType)
                
            case let .fromResources(content):
                try content.encode(to: encoder)
                try container.encode(ProductionType.fromResources, forKey: .productionType)
                
            case let .power(content):
                try content.encode(to: encoder)
                try container.encode(ProductionType.power, forKey: .productionType)
            }
        }
        
        package mutating func migrate(migration: Migration) {
            switch self {
            case let .singleItem(content):
                var copy = content
                copy.migrate(migration)
                self = .singleItem(copy)
                
            case let .fromResources(content):
                var copy = content
                copy.migrate(migration)
                self = .fromResources(copy)
                
            case let .power(content):
                var copy = content
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
