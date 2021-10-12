private extension Part {
    init(name: String, sortingPriority: Int) {
        self.init(name: name, partType: .powerSlugs, tier: .tier0, milestone: 0, sortingPriority: sortingPriority, rawResource: true)
    }
}

let greenPowerSlug = Part(name: "Green Power Slug", sortingPriority: 3)
let yellowPowerSlug = Part(name: "Yellow Power Slug", sortingPriority: 4)
let purplePowerSlug = Part(name: "Purple Power Slug", sortingPriority: 5)

let PowerSlugs = [
    greenPowerSlug,
    yellowPowerSlug,
    purplePowerSlug
]
