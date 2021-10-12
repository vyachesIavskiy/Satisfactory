private extension Part {
    init(name: String, tier: Tier, milestone: Int, sortingPriority: Int) {
        self.init(name: name, partType: .consumed, tier: tier, milestone: milestone, sortingPriority: sortingPriority)
    }
}

let colorCartridge = Part(name: "Color Cartridge", tier: .tier0, milestone: 0, sortingPriority: 14)
let spikedRebar = Part(name: "Spiked Rebar", tier: .tier0, milestone: 0, sortingPriority: 58)
let blackPowder = Part(name: "Black Powder", tier: .tier0, milestone: 0, sortingPriority: 45)
let nobelisk = Part(name: "Nobelisk", tier: .tier3, milestone: 2, sortingPriority: 66)
let rifleCartridge = Part(name: "Rifle Cartridge", tier: .tier5, milestone: 0, sortingPriority: 99)
let gasFilter = Part(name: "Gas Filter", tier: .tier5, milestone: 0, sortingPriority: 92)
let iodineInfusedFilter = Part(name: "Iodine Infused Filter", tier: .tier7, milestone: 0, sortingPriority: 100)

let Consumed = [
    colorCartridge,
    spikedRebar,
    blackPowder,
    nobelisk,
    rifleCartridge,
    gasFilter,
    iodineInfusedFilter
]
