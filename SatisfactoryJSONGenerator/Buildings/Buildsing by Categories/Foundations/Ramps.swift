private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .ramps)
    }
}

let ramp8x1 = Building(name: "Ramp 8m x 1m")
let ramp8x2 = Building(name: "Ramp 8m x 2m")
let ramp8x4 = Building(name: "Ramp 8m x 4m")
let upCornerRamp8x1 = Building(name: "Up Corner Ramp 8m x 1m")
let upCornerRamp8x2 = Building(name: "Up Corner Ramp 8m x 2m")
let upCornerRamp8x4 = Building(name: "Up Corner Ramp 8m x 4m")
let downCornerRamp8x1 = Building(name: "Down Corner Ramp 8m x 1m")
let downCornerRamp8x2 = Building(name: "Down Corner Ramp 8m x 2m")
let downCornerRamp8x4 = Building(name: "Down Corner Ramp 8m x 4m")
let doubleRamp8x2 = Building(name: "Double Ramp 8m x 2m")
let doubleRamp8x4 = Building(name: "Double Ramp 8m x 4m")
let doubleRamp8x8 = Building(name: "Double Ramp 8m x 8m")

let Ramps = [
    ramp8x1,
    ramp8x2,
    ramp8x4,
    upCornerRamp8x1,
    upCornerRamp8x2,
    upCornerRamp8x4,
    downCornerRamp8x1,
    downCornerRamp8x2,
    downCornerRamp8x4,
    doubleRamp8x2,
    doubleRamp8x4,
    doubleRamp8x8
]
