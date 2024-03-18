import Models
import StaticModels

private extension Building.Static.Legacy {
    init(id: String, name: String) {
        self.init(id: id, name: name, buildingType: "Workstations")
    }
}

extension Legacy.Buildings {
    static let craftBench = Building.Static.Legacy(id: "building-craft-bench", name: "Craft Bench")
    static let equipmentWorkshop = Building.Static.Legacy(id: "building-equipment-workshop", name: "Equipment Workshop")
    
    static let workstationBuildingsV2 = [
        craftBench,
        equipmentWorkshop,
    ]
}
