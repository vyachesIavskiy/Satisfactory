import StaticModels

extension Migration.IDs {
    init(old: EquipmentLegacy, new: Equipment) {
        self.init(oldID: old.id, newID: new.id)
    }
}

extension LegacyToV2 {
    enum Equipment {
        static let all = handsEquipment
    }
}
