import Foundation
import SHModels

extension Production.Persistent {
    public enum V2: Codable, Hashable {
        case singleItem(SingleItemProduction.Persistent.V2)
        case fromResources(FromResourcesProduction.Persistent.V2)
        case power(PowerProduction.Persistent.V2)
        
        enum CodingKeys: String, CodingKey {
            case productionType
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
    }
}

enum ProductionType: String, Codable {
    case singleItem
    case fromResources
    case power
}
