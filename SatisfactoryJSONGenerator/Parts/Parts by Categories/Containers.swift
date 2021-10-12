private extension Part {
    init(name: String, tier: Tier, milestone: Int, sortingPriority: Int) {
        self.init(name: name, partType: .containers, tier: tier, milestone: milestone, sortingPriority: sortingPriority)
    }
}

let emptyCanister = Part(name: "Empty Canister", tier: .tier5, milestone: 0, sortingPriority: 59)
let emptyFluidTank = Part(name: "Empty Fluid Tank", tier: .tier8, milestone: 1, sortingPriority: 80)
let pressureConversionCube = Part(name: "Pressure Conversion Cube", tier: .tier8, milestone: 3, sortingPriority: 103)
let packagedWater = Part(name: "Packaged Water", tier: .tier5, milestone: 0, sortingPriority: 81)
let packagedOil = Part(name: "Packaged Oil", tier: .tier5, milestone: 0, sortingPriority: 82)
let packagedHeavyOilResidue = Part(name: "Packaged Heavy Oil Residue", tier: .tier5, milestone: 0, sortingPriority: 83)
let packagedFuel = Part(name: "Packaged Fuel", tier: .tier5, milestone: 0, sortingPriority: 84)
let packagedLiquidBiofuel = Part(name: "Packaged Liquid Biofuel", tier: .tier5, milestone: 0, sortingPriority: 85)
let packagedTurbofuel = Part(name: "Packaged Turbofuel", tier: .tier5, milestone: 0, sortingPriority: 86)
let packagedAluminaSolution = Part(name: "Packaged Alumina Solution", tier: .tier7, milestone: 0, sortingPriority: 87)
let packagedSulfuricAcid = Part(name: "Packaged Sulfuric Acid", tier: .tier7, milestone: 2, sortingPriority: 88)
let packagedNitricAcid = Part(name: "Packaged Nitric Acid", tier: .tier8, milestone: 3, sortingPriority: 89)
let packagedNitrogenGas = Part(name: "Packaged Nitrogen Gas", tier: .tier8, milestone: 1, sortingPriority: 90)

let Containers = [
    emptyCanister,
    emptyFluidTank,
    pressureConversionCube,
    packagedWater,
    packagedOil,
    packagedFuel,
    packagedHeavyOilResidue,
    packagedLiquidBiofuel,
    packagedTurbofuel,
    packagedAluminaSolution,
    packagedSulfuricAcid,
    packagedNitricAcid,
    packagedNitrogenGas
]
