import SHModels
import SHPersistentModels

extension Pins {
    init(_ v2: Pins.Persistent.V2) {
        self.init(
            singleItemPartIDs: v2.singleItemPartIDs,
            fromResourcesPartIDs: v2.fromResourcesPartIDs,
            power: Power(buildingIDs: v2.powerBuildingIDs, partIDs: v2.powerPartIDs),
            recipeIDs: v2.recipeIDs
        )
    }
}

extension Pins.Persistent.V2 {
    init(_ pins: Pins) {
        self.init(
            singleItemPartIDs: pins.singleItemPartIDs,
            fromResourcesPartIDs: pins.fromResourcesPartIDs,
            powerPartIDs: pins.power.partIDs,
            powerBuildingIDs: pins.power.buildingIDs,
            recipeIDs: pins.recipeIDs
        )
    }
}
