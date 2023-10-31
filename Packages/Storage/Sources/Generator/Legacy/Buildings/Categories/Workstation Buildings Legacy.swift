import StaticModels

private extension BuildingLegacy {
    init(id: String, name: String) {
        self.init(id: id, name: name, buildingType: "Workstations")
    }
}

extension Legacy.Buildings {
    static let craftBench = BuildingLegacy(id: "building-craft-bench", name: "Craft Bench")
    static let equipmentWorkshop = BuildingLegacy(id: "building-equipment-workshop", name: "Equipment Workshop")
    
    static let workstationBuildingsV2 = [
        craftBench,
        equipmentWorkshop,
    ]
}
