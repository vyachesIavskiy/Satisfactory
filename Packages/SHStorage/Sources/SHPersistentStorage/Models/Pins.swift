import SHModels
import SHPersistentModels

extension Pins {
    init(_ v2: Pins.Persistent.V2) {
        self.init(
            singleItem: SingleItem(partIDs: v2.singleItemPartIDs, equipmentIDs: v2.singleItemEquipmentIDs),
            fromResources: FromResources(partIDs: v2.fromResourcesPartIDs, equipmentIDs: v2.fromResourcesEquipmentIDs),
            power: Power(buildingIDs: v2.powerBuildingIDs, partIDs: v2.powerPartIDs),
            recipeIDs: v2.recipeIDs
        )
    }
}

extension Pins.Persistent.V2 {
    init(_ pins: Pins) {
        self.init(
            singleItemPartIDs: pins.singleItem.partIDs,
            fromResourcesPartIDs: pins.fromResources.partIDs,
            powerPartIDs: pins.power.partIDs,
            singleItemEquipmentIDs: pins.singleItem.equipmentIDs,
            fromResourcesEquipmentIDs: pins.fromResources.equipmentIDs,
            powerBuildingIDs: pins.power.buildingIDs,
            recipeIDs: pins.recipeIDs
        )
    }
}
