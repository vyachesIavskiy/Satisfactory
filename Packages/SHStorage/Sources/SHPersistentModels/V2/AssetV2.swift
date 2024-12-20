import Foundation
import SHModels

extension Asset.Persistent {
    package enum V2: Codable, Hashable {
        case legacy
        case abbreviation
        case assetCatalog(name: String)
        
        enum CodingValue: String {
            case legacy
            case abbreviation
            case assetCatalog
        }
        
        enum CodingKeys: String, CodingKey {
            case assetTypeRawValue
            case value
        }
        
        package init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let codingRawValue = try container.decode(String.self, forKey: .assetTypeRawValue)
            guard let codingValue = CodingValue(rawValue: codingRawValue) else {
                throw DecodingError.typeMismatch(
                    CodingValue.self,
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Unsupported value found for CodingValue."
                    )
                )
            }
            switch codingValue {
            case .legacy:
                self = .legacy
                
            case .abbreviation:
                self = .abbreviation
                
            case .assetCatalog:
                let value = try container.decode(String.self, forKey: .value)
                self = .assetCatalog(name: value)
            }
        }
        
        package func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            let codingValue: CodingValue = switch self {
            case .legacy: .legacy
            case .abbreviation: .abbreviation
            case .assetCatalog: .assetCatalog
            }
            try container.encode(codingValue.rawValue, forKey: .assetTypeRawValue)
            switch self {
            case .legacy, .abbreviation:
                break // No assotiate value
                
            case let .assetCatalog(name):
                try container.encode(name, forKey: .value)
            }
        }
    }
}
