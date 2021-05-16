private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .conveyorBelts)
    }
}

let conveyorBeltMK1 = Building(name: "Conveyor Belt MK.1")
let conveyorBeltMK2 = Building(name: "Conveyor Belt MK.2")
let conveyorBeltMK3 = Building(name: "Conveyor Belt MK.3")
let conveyorBeltMK4 = Building(name: "Conveyor Belt MK.4")
let conveyorBeltMK5 = Building(name: "Conveyor Belt MK.5")

let ConveyorBelts = [
    conveyorBeltMK1,
    conveyorBeltMK2,
    conveyorBeltMK3,
    conveyorBeltMK4,
    conveyorBeltMK5
]
