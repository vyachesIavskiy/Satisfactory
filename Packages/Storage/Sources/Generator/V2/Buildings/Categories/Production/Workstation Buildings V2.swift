import StaticModels

private extension Building {
    init(id: String) {
        self.init(id: id, category: .workstations)
    }
}

extension V2.Buildings {
    static let craftBench = Building(id: "building-craft-bench")
    static let equipmentWorkshop = Building(id: "building-equipment-workshop")
    
    static let workstationBuildingsV2 = [
        craftBench,
        equipmentWorkshop,
    ]
}
