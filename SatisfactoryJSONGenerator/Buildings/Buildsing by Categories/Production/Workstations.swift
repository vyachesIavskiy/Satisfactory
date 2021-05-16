private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .workstations)
    }
}

let craftBench = Building(name: "Craft Bench")
let equipmentWorkshop = Building(name: "Equipment Workshop")

let WorkStations = [
    craftBench,
    equipmentWorkshop
]
