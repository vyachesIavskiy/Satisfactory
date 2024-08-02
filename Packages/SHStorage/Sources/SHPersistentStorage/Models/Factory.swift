import Foundation
import SHModels
import SHPersistentModels

extension Factory {
    init(_ v2: Persistent.V2) {
        self.init(
            id: v2.id,
            name: v2.name,
            assetType: AssetType(v2.assetType),
            productionIDs: v2.productionIDs
        )
    }
}

extension Factory.Persistent.V2 {
    init(_ factory: Factory) {
        self.init(
            id: factory.id,
            name: factory.name,
            assetType: AssetType(factory.assetType),
            productionIDs: factory.productionIDs
        )
    }
}

extension Factory.AssetType {
    init(_ v2: Factory.Persistent.V2.AssetType) {
        self = switch v2 {
        case .abbreviation: .abbreviation
        case let .assetCatalog(name): .assetCatalog(name: name)
        case .legacy: .legacy
        }
    }
}

extension Factory.Persistent.V2.AssetType {
    init(_ asset: Factory.AssetType) {
        self = switch asset {
        case .abbreviation: .abbreviation
        case let .assetCatalog(name): .assetCatalog(name: name)
        case .legacy: .legacy
        }
    }
}
