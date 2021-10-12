private extension Part {
    init(name: String, sortingPriority: Int) {
        self.init(name: name, partType: .aliens, tier: .tier0, milestone: 0, sortingPriority: sortingPriority, rawResource: true)
    }
}

let alienCarapace = Part(name: "Alien Carapace", sortingPriority: 1)
let alienOrgans = Part(name: "Alien Organs", sortingPriority: 2)

let Aliens = [
    alienCarapace,
    alienOrgans,
]
