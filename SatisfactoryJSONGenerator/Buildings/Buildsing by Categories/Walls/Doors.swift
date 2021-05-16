private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .doors)
    }
}

let leftDoorWall = Building(name: "Left Door Wall")
let centerDoorWall = Building(name: "Center Door Wall")
let rightDoorWall = Building(name: "Right Door Wall")
let leftDoorWallGray = Building(name: "Left Door Wall")
let centerDoorWallGray = Building(name: "Center Door Wall")
let rightDoorWallGray = Building(name: "Right Door Wall")
let gateWall = Building(name: "Gate Wall")

let Doors = [
    leftDoorWall,
    centerDoorWall,
    rightDoorWall,
    leftDoorWallGray,
    centerDoorWallGray,
    rightDoorWallGray,
    gateWall
]
