import StaticModels

extension Migration.IDs {
    init(old: BuildingLegacy, new: Building) {
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
