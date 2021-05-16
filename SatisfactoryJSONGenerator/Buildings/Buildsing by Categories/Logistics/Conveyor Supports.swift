private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .conveyorSupports)
    }
}

let conveyorPole = Building(name: "Conveyor Pole")
let stackableConveyorPole = Building(name: "Stackable Conveyor Pole")
let conveyorWallMount = Building(name: "Conveyor Wall Mount")

let ConveyorSupports = [
    conveyorPole,
    stackableConveyorPole,
    conveyorWallMount
]
