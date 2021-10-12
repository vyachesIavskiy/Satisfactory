private extension Part {
    init(name: String, sortingPriority: Int) {
        self.init(name: name, partType: .ores, tier: .tier0, milestone: 0, sortingPriority: sortingPriority, rawResource: true)
    }
}

let ironOre = Part(name: "Iron Ore", sortingPriority: 25)
let copperOre = Part(name: "Copper Ore", sortingPriority: 26)
let limestone = Part(name: "Limestone", sortingPriority: 27)
let coal = Part(name: "Coal", sortingPriority: 28)
let cateriumOre = Part(name: "Caterium Ore", sortingPriority: 29)
let bauxite = Part(name: "Bauxite", sortingPriority: 30)
let rawQuartz = Part(name: "Raw Quartz", sortingPriority: 31)
let sulfur = Part(name: "Sulfur", sortingPriority: 32)
let uranium = Part(name: "Uranium", sortingPriority: 33)
let samOre = Part(name: "S.A.M. Ore", sortingPriority: 34)

let Ores = [
    ironOre,
    copperOre,
    limestone,
    coal,
    rawQuartz,
    cateriumOre,
    sulfur,
    bauxite,
    uranium,
    samOre
]
