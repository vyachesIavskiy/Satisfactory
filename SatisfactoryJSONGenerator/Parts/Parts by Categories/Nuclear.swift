private extension Part {
    init(name: String, milestone: Int, sortingPriority: Int) {
        self.init(name: name, partType: .nuclear, tier: .tier8, milestone: milestone, sortingPriority: sortingPriority)
    }
}

let electromagneticControlRod = Part(name: "Electromagnetic Control Rod", milestone: 0, sortingPriority: 73)
let encasedUraniumCell = Part(name: "Encased Uranium Cell", milestone: 0, sortingPriority: 110)
let uraniumFuelRod = Part(name: "Uranium Fuel Rod", milestone: 0, sortingPriority: 111)
let uraniumWaste = Part(name: "Uranium Waste", milestone: 0, sortingPriority: 112)
let nonFissileUranium = Part(name: "Non-fissile Uranium", milestone: 3, sortingPriority: 113)
let plutoniumPellet = Part(name: "Plutonium Pellet", milestone: 3, sortingPriority: 114)
let encasedPlutoniumCell = Part(name: "Encased Plutonium Cell", milestone: 3, sortingPriority: 115)
let plutoniumFuelRod = Part(name: "Plutonium Fuel Rod", milestone: 3, sortingPriority: 116)
let plutoniumWaste = Part(name: "Plutonium Waste", milestone: 3, sortingPriority: 117)

let Nuclear = [
    electromagneticControlRod,
    encasedUraniumCell,
    uraniumFuelRod,
    uraniumWaste,
    nonFissileUranium,
    plutoniumPellet,
    encasedPlutoniumCell,
    plutoniumFuelRod,
    plutoniumWaste
]
