private extension Part {
    init(name: String, tier: Tier, milestone: Int, sortingPriority: Int) {
        self.init(name: name, partType: .ingots, tier: tier, milestone: milestone, sortingPriority: sortingPriority)
    }
}

let ironIngot = Part(name: "Iron Ingot", tier: .tier0, milestone: 0, sortingPriority: 35)
let copperIngot = Part(name: "Copper Ingot", tier: .tier0, milestone: 0, sortingPriority: 36)
let steelIngot = Part(name: "Steel Ingot", tier: .tier3, milestone: 2, sortingPriority: 47)
let cateriumIngot = Part(name: "Caterium Ingot", tier: .tier6, milestone: 0, sortingPriority: 54)
let aluminumIngot = Part(name: "Aluminum Ingot", tier: .tier7, milestone: 0, sortingPriority: 61)

let Ingots = [
    ironIngot,
    copperIngot,
    steelIngot,
    cateriumIngot,
    aluminumIngot
]
