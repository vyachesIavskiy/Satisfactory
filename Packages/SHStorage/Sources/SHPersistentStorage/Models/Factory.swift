import SHModels
import SHPersistentModels

extension Factory {
    init(_ v2: Persistent.V2) {
        self.init(
            id: v2.id,
            name: v2.name,
            asset: Asset(v2.asset),
            productionIDs: v2.productionIDs
        )
    }
}

extension Factory.Persistent.V2 {
    init(_ factory: Factory) {
        self.init(
            id: factory.id,
            name: factory.name,
            asset: Asset.Persistent.V2(factory.asset),
            productionIDs: factory.productionIDs
        )
    }
}
