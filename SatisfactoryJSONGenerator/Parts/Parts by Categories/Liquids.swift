private extension Part {
    init(name: String, tier: Tier, milestone: Int, sortingPriority: Int, rawResource: Bool = false) {
        self.init(name: name, partType: .liquids, tier: tier, milestone: milestone, sortingPriority: sortingPriority, rawResource: rawResource)
    }
}

let water = Part(name: "Water", tier: .tier0, milestone: 0, sortingPriority: 16, rawResource: true)
let crudeOil = Part(name: "Crude Oil", tier: .tier5, milestone: 0, sortingPriority: 17, rawResource: true)
let heavyOilResidue = Part(name: "Heavy Oil Residue", tier: .tier5, milestone: 0, sortingPriority: 18)
let fuel = Part(name: "Fuel", tier: .tier5, milestone: 0, sortingPriority: 19)
let liquidBiofuel = Part(name: "Liquid Biofuel", tier: .tier5, milestone: 2, sortingPriority: 20)
let turbofuel = Part(name: "Turbofuel", tier: .tier5, milestone: 0, sortingPriority: 21)
let aluminaSolution = Part(name: "Alumina Solution", tier: .tier7, milestone: 0, sortingPriority: 22)
let sulfuricAcid = Part(name: "Sulfuric Acid", tier: .tier7, milestone: 2, sortingPriority: 23)
let nitricAcid = Part(name: "Nitric Acid", tier: .tier8, milestone: 3, sortingPriority: 24)

let Liquids = [
    water,
    crudeOil,
    heavyOilResidue,
    fuel,
    liquidBiofuel,
    turbofuel,
    aluminaSolution,
    sulfuricAcid,
    nitricAcid
]
