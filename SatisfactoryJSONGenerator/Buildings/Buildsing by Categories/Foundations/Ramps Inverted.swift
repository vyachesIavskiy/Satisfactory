private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .rampsInverted)
    }
}

let invertedRamp8x1 = Building(name: "Inverted Ramp 8m x 1m")
let invertedRamp8x2 = Building(name: "Inverted Ramp 8m x 2m")
let invertedRamp8x4 = Building(name: "Inverted Ramp 8m x 4m")
let upCornerRamp8x1Inverted = Building(name: "Up Corner Ramp 8m x 1m Inverted")
let upCornerRamp8x2Inverted = Building(name: "Up Corner Ramp 8m x 2m Inverted")
let upCornerRamp8x4Inverted = Building(name: "Up Corner Ramp 8m x 4m Inverted")
let downCornerRamp8x1Inverted = Building(name: "Down Corner Ramp 8m x 1m Inverted")
let downCornerRamp8x2Inverted = Building(name: "Down Corner Ramp 8m x 2m Inverted")
let downCornerRamp8x4Inverted = Building(name: "Down Corner Ramp 8m x 4m Inverted")

let InvertedRamps = [
    invertedRamp8x1,
    invertedRamp8x2,
    invertedRamp8x4,
    upCornerRamp8x1Inverted,
    upCornerRamp8x2Inverted,
    upCornerRamp8x4Inverted,
    downCornerRamp8x1Inverted,
    downCornerRamp8x2Inverted,
    downCornerRamp8x4Inverted
]
