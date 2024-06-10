import SHModels
import SHStaticModels

extension Migration.IDs {
    init(old: Equipment.Static.Legacy, new: Equipment.Static) {
        self.init(oldID: old.id, newID: new.id)
    }
}

extension LegacyToV2 {
    enum Equipment {
        static let all = handsEquipment
    }
}
