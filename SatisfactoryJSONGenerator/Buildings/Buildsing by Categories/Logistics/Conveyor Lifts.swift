private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .conveyorLifts)
    }
}

let conveyorLiftMK1 = Building(name: "Conveyor Lift MK.1")
let conveyorLiftMK2 = Building(name: "Conveyor Lift MK.2")
let conveyorLiftMK3 = Building(name: "Conveyor Lift MK.3")
let conveyorLiftMK4 = Building(name: "Conveyor Lift MK.4")
let conveyorLiftMK5 = Building(name: "Conveyor Lift MK.5")

let ConveyorLifts = [
    conveyorLiftMK1,
    conveyorLiftMK2,
    conveyorLiftMK3,
    conveyorLiftMK4,
    conveyorLiftMK5
]
