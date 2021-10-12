private extension Part {
    init(name: String, sortingPriority: Int) {
        self.init(name: name, partType: .oilProducts, tier: .tier5, milestone: 0, sortingPriority: sortingPriority)
    }
}

let petroleumCoke = Part(name: "Petroleum Coke", sortingPriority: 50)
let polymerResin = Part(name: "Polymer Resin", sortingPriority: 51)
let rubber = Part(name: "Rubber", sortingPriority: 52)
let plastic = Part(name: "Plastic", sortingPriority: 53)

let OilProducts = [
    rubber,
    plastic,
    petroleumCoke,
    polymerResin
]
