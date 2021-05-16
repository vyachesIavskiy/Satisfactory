private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .jumpPads)
    }
}

let jumpPad = Building(name: "Jump Pad")
let ujellyLandingPad = Building(name: "U-Jelly Landing Pad")

let JumpPads = [
    jumpPad,
    ujellyLandingPad
]
