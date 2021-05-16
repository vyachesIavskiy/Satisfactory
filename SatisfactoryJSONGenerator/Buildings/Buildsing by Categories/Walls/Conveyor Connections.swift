private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .conveyorConnections)
    }
}

let wallConveyor3Gray = Building(name: "Wall Conveyor x3")
let wallConveyor2Gray = Building(name: "Wall Conveyor x2")
let wallConveyor1Gray = Building(name: "Wall Conveyor x1")
let wallConveyor3 = Building(name: "Wall Conveyor x3")
let wallConveyor2 = Building(name: "Wall Conveyor x2")
let wallConveyor1 = Building(name: "Wall Conveyor x1")

let ConveyourConnections = [
    wallConveyor3Gray,
    wallConveyor2Gray,
    wallConveyor1Gray,
    wallConveyor3,
    wallConveyor2,
    wallConveyor1
]
