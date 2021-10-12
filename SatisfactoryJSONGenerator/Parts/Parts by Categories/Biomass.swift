private extension Part {
    init(name: String, tier: Tier, milestone: Int, sortingPriority: Int) {
        self.init(name: name, partType: .biomass, tier: tier, milestone: milestone, sortingPriority: sortingPriority)
    }
}

let biomass = Part(name: "Biomass", tier: .tier0, milestone: 5, sortingPriority: 11)
let solidBiofuel = Part(name: "Solid Biofuel", tier: .tier2, milestone: 1, sortingPriority: 12)
let fabric = Part(name: "Fabric", tier: .tier0, milestone: 0, sortingPriority: 13)

let Biomasses = [
    biomass,
    solidBiofuel,
    fabric
]
