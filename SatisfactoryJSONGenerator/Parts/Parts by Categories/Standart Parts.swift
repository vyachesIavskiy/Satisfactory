private extension Part {
    init(name: String, tier: Tier, milestone: Int, sortingPriority: Int) {
        self.init(name: name, partType: .standartParts, tier: tier, milestone: milestone, sortingPriority: sortingPriority)
    }
}

let ironRod = Part(name: "Iron Rod", tier: .tier0, milestone: 0, sortingPriority: 37)
let ironPlate = Part(name: "Iron Plate", tier: .tier0, milestone: 0, sortingPriority: 38)
let screw = Part(name: "Screw", tier: .tier0, milestone: 2, sortingPriority: 39)
let reinforcedIronPlate = Part(name: "Reinforced Iron Plate", tier: .tier0, milestone: 2, sortingPriority: 62)
let copperSheet = Part(name: "Copper Sheet", tier: .tier2, milestone: 0, sortingPriority: 42)
let modularFrame = Part(name: "Modular Frame", tier: .tier2, milestone: 0, sortingPriority: 69)
let steelBeam = Part(name: "Steel Beam", tier: .tier3, milestone: 2, sortingPriority: 48)
let steelPipe = Part(name: "Steel Pipe", tier: .tier3, milestone: 2, sortingPriority: 49)
let encasedIndustrialBeam = Part(name: "Encased Industrial Beam", tier: .tier4, milestone: 0, sortingPriority: 65)
let heavyModularFrame = Part(name: "Heavy Modular Frame", tier: .tier4, milestone: 0, sortingPriority: 96)
let alcladAluminumSheet = Part(name: "Alclad Aluminum Sheet", tier: .tier7, milestone: 0, sortingPriority: 74)
let aluminumCasing = Part(name: "Aluminum Casing", tier: .tier7, milestone: 0, sortingPriority: 75)

let StandartParts = [
    ironPlate,
    ironRod,
    screw,
    reinforcedIronPlate,
    copperSheet,
    modularFrame,
    steelBeam,
    steelPipe,
    encasedIndustrialBeam,
    heavyModularFrame,
    alcladAluminumSheet,
    aluminumCasing
]
