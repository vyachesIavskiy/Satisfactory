import SHModels
import SHPersistentModels

extension Asset {
    init(_ v2: Persistent.V2) {
        self = switch v2 {
        case .abbreviation: .abbreviation
        case let .assetCatalog(name): .assetCatalog(name: name)
        case .legacy: .legacy
        }
    }
}

extension Asset.Persistent.V2 {
    init(_ asset: Asset) {
        self = switch asset {
        case .abbreviation: .abbreviation
        case let .assetCatalog(name): .assetCatalog(name: name)
        case .legacy: .legacy
        }
    }
}
