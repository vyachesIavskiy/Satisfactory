private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .foundations)
    }
}

let foundation8x1 = Building(name: "Foundation 8m x 1m")
let foundation8x2 = Building(name: "Foundation 8m x 2m")
let foundation8x4 = Building(name: "Foundation 8m x 4m")
let glassFoundation8x1 = Building(name: "Glass Foundation 8m x 1m")
let frameFoundation8x4 = Building(name: "Frame Foundation 8m x 4m")
let pillarBase = Building(name: "Pillar Base")
let pillarMiddle = Building(name: "Pillar Middle")
let pillarTop = Building(name: "Pillar Top")

let Foundations = [
    foundation8x1,
    foundation8x2,
    foundation8x4,
    glassFoundation8x1,
    frameFoundation8x4,
    pillarBase,
    pillarMiddle,
    pillarTop
]
