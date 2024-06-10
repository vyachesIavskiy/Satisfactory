import SHModels
import SHStaticModels

private extension Building.Static {
    init(id: String) {
        self.init(id: id, category: .workstations)
    }
}

extension V2.Buildings {
    static let craftBench = Building.Static(id: "building-craft-bench")
    static let equipmentWorkshop = Building.Static(id: "building-equipment-workshop")
    
    static let workstationBuildingsV2 = [
        craftBench,
        equipmentWorkshop,
    ]
}
