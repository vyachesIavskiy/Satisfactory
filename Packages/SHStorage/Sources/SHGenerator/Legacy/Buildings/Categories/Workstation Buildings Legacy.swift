import SHModels
import SHStaticModels

private extension Building.Static.Legacy {
    init(id: String, name: String) {
        self.init(id: id, name: name, buildingType: "Workstations")
    }
}

extension Legacy.Buildings {
    static let craftBench = Building.Static.Legacy(id: "craft-bench", name: "Craft Bench")
    static let equipmentWorkshop = Building.Static.Legacy(id: "equipment-workshop", name: "Equipment Workshop")
    
    static let workstationBuildingsV2 = [
        craftBench,
        equipmentWorkshop,
    ]
}
