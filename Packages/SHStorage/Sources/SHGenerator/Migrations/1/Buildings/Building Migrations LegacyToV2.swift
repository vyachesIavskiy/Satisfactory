import SHModels
import SHStaticModels

extension Migration.IDs {
    init(old: Building.Static.Legacy, new: Building.Static) {
        self.init(oldID: old.id, newID: new.id)
    }
}

extension LegacyToV2 {
    enum Buildings {
        static let all =
        generatorBuildings +
        manufacturerBuildings +
        smelterBuildings +
        workstationBuildings
    }
}
