private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .attachments)
    }
}

let ladder = Building(name: "Ladder")
let fence = Building(name: "Fence")
let stairsLeft = Building(name: "Stairs Left")
let stairsRight = Building(name: "Stairs Right")

let Attachments = [
    ladder,
    fence,
    stairsLeft,
    stairsRight,
]
