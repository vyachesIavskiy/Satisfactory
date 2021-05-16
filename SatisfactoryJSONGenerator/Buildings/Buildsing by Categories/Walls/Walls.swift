private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .walls)
    }
}

let wall8x4 = Building(name: "Wall 8m x 4m")
let wall8x4Gray = Building(name: "Wall 8m x 4m")

let Walls = [
    wall8x4,
    wall8x4Gray
]
