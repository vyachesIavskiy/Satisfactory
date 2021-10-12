private extension Part {
    init(name: String, tier: Tier, milestone: Int, sortingPriority: Int) {
        self.init(name: name, partType: .communications, tier: tier, milestone: milestone, sortingPriority: sortingPriority)
    }
}

let crystalOscillator = Part(name: "Crystal Oscillator", tier: .tier0, milestone: 2, sortingPriority: 76)
let computer = Part(name: "Computer", tier: .tier5, milestone: 2, sortingPriority: 79)
let radioControlUnit = Part(name: "Radio Control Unit", tier: .tier7, milestone: 0, sortingPriority: 95)
let supercomputer = Part(name: "Supercomputer", tier: .tier7, milestone: 3, sortingPriority: 98)

let Communications = [
    crystalOscillator,
    computer,
    radioControlUnit,
    supercomputer
]
