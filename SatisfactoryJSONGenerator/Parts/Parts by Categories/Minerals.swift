private extension Part {
    init(name: String, tier: Tier, milestone: Int, sortingPriority: Int) {
        self.init(name: name, partType: .minerals, tier: tier, milestone: milestone, sortingPriority: sortingPriority)
    }
}

let concrete = Part(name: "Concrete", tier: .tier0, milestone: 2, sortingPriority: 44)
let quartzCrystal = Part(name: "Quartz Crystal", tier: .tier7, milestone: 0, sortingPriority: 56)
let silica = Part(name: "Silica", tier: .tier7, milestone: 0, sortingPriority: 57)
let aluminumScrap = Part(name: "Aluminum Scrap", tier: .tier7, milestone: 0, sortingPriority: 60)
let copperPowder = Part(name: "Copper Powder", tier: .tier8, milestone: 3, sortingPriority: 43)

let Minerals = [
    concrete,
    quartzCrystal,
    silica,
    copperPowder,
    aluminumScrap
]
