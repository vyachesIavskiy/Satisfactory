import SHModels
import SHPersistentModels

extension Pins {
    init(_ v2: Pins.Persistent.V2) {
        self.init(partIDs: v2.partIDs, equipmentIDs: v2.equipmentIDs, recipeIDs: v2.recipeIDs)
    }
}

extension Pins.Persistent.V2 {
    init(_ pins: Pins) {
        self.init(partIDs: pins.partIDs, equipmentIDs: pins.equipmentIDs, recipeIDs: pins.recipeIDs)
    }
}
