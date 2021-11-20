private extension Part {
    init(name: String, tier: Tier, milestone: Int, sortingPriority: Int) {
        self.init(name: name, partType: .spaceElevatorParts, tier: tier, milestone: milestone, sortingPriority: sortingPriority)
    }
}

let smartPlating = Part(name: "Smart Plating", tier: .tier2, milestone: 0, sortingPriority: 70)
let automatedWiring = Part(name: "Automated Wiring", tier: .tier4, milestone: 0, sortingPriority: 71)
let versatileFramework = Part(name: "Versatile Framework", tier: .tier3, milestone: 2, sortingPriority: 78)
let modularEngine = Part(name: "Modular Engine", tier: .tier5, milestone: 1, sortingPriority: 93)
let adaptiveControlUnit = Part(name: "Adaptive Control Unit", tier: .tier5, milestone: 1, sortingPriority: 104)
let magneticFieldGenerator = Part(name: "Magnetic Field Generator", tier: .tier8, milestone: 0, sortingPriority: 105)
let nuclearPasta = Part(name: "Nuclear Pasta", tier: .tier8, milestone: 3, sortingPriority: 106)
let assemblyDirectorSystem = Part(name: "Assembly Director System", tier: .tier7, milestone: 2, sortingPriority: 107)
let thermalPropulsionRocket = Part(name: "Thermal Propulsion Rocket", tier: .tier8, milestone: 2, sortingPriority: 109)

let SpaceElevatorParts = [
    smartPlating,
    versatileFramework,
    automatedWiring,
    modularEngine,
    adaptiveControlUnit,
    assemblyDirectorSystem,
    magneticFieldGenerator,
    thermalPropulsionRocket,
    nuclearPasta
]
