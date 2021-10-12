private extension Part {
    init(name: String, tier: Tier, milestone: Int, sortingPriority: Int) {
        self.init(name: name, partType: .industrialParts, tier: tier, milestone: milestone, sortingPriority: sortingPriority)
    }
}

let rotor = Part(name: "Rotor", tier: .tier2, milestone: 0, sortingPriority: 63)
let stator = Part(name: "Stator", tier: .tier4, milestone: 0, sortingPriority: 64)
let motor = Part(name: "Motor", tier: .tier4, milestone: 0, sortingPriority: 72)
let heatSink = Part(name: "Heat Sink", tier: .tier8, milestone: 1, sortingPriority: 77)
let coolingSystem = Part(name: "Cooling System", tier: .tier8, milestone: 1, sortingPriority: 101)
let fusedModularFrame = Part(name: "Fused Modular Frame", tier: .tier8, milestone: 1, sortingPriority: 102)
let battery = Part(name: "Battery", tier: .tier7, milestone: 2, sortingPriority: 97)
let turboMotor = Part(name: "Turbo Motor", tier: .tier8, milestone: 2, sortingPriority: 108)

let IndustrialParts = [
    rotor,
    stator,
    motor,
    heatSink,
    coolingSystem,
    fusedModularFrame,
    battery,
    turboMotor
]
