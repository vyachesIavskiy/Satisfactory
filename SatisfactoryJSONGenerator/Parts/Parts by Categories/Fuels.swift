private extension Part {
    init(name: String, sortingPriority: Int) {
        self.init(name: name, partType: .fuels, tier: .tier0, milestone: 0, sortingPriority: sortingPriority, rawResource: true)
    }
}

let leaves = Part(name: "Leaves", sortingPriority: 6)
let wood = Part(name: "Wood", sortingPriority: 7)
let mycelia = Part(name: "Mycelia", sortingPriority: 8)
let flowerPetals = Part(name: "Flower Petals", sortingPriority: 9)
let compactedCoal = Part(name: "Compacted Coal", sortingPriority: 46)

let Fuels = [
    leaves,
    wood,
    mycelia,
    flowerPetals,
    compactedCoal
]
