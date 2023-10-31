import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .containers, form: .solid)
    }
}

extension V2.Parts {
    static let emptyCanister = Part(id: "part-empty-canister")
    static let emptyFluidTank = Part(id: "part-empty-fluid-tank")
    static let pressureConversionCube = Part(id: "part-pressure-conversion-cube")
    static let packagedWater = Part(id: "part-packaged-water")
    static let packagedOil = Part(id: "part-packaged-oil")
    static let packagedHeavyOilResidue = Part(id: "part-packaged-heavy-oil-residue")
    static let packagedFuel = Part(id: "part-packaged-fuel")
    static let packagedLiquidBiofuel = Part(id: "part-packaged-liquid-biofuel")
    static let packagedTurbofuel = Part(id: "part-packaged-turbofuel")
    static let packagedAluminaSolution = Part(id: "part-packaged-alumina-solution")
    static let packagedSulfuricAcid = Part(id: "part-packaged-sulfuric-acid")
    static let packagedNitricAcid = Part(id: "part-packaged-nitric-acid")
    static let packagedNitrogenGas = Part(id: "part-packaged-nitrogen-gas")
    
    static let containerParts = [
        emptyCanister,
        emptyFluidTank,
        pressureConversionCube,
        packagedWater,
        packagedOil,
        packagedHeavyOilResidue,
        packagedFuel,
        packagedLiquidBiofuel,
        packagedTurbofuel,
        packagedAluminaSolution,
        packagedSulfuricAcid,
        packagedNitricAcid,
        packagedNitrogenGas
    ]
}
