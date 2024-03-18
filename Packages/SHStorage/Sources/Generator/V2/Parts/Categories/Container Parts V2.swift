import Models
import StaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .containers, form: .solid)
    }
}

extension V2.Parts {
    static let emptyCanister = Part.Static(id: "part-empty-canister")
    static let emptyFluidTank = Part.Static(id: "part-empty-fluid-tank")
    static let pressureConversionCube = Part.Static(id: "part-pressure-conversion-cube")
    static let packagedWater = Part.Static(id: "part-packaged-water")
    static let packagedOil = Part.Static(id: "part-packaged-oil")
    static let packagedHeavyOilResidue = Part.Static(id: "part-packaged-heavy-oil-residue")
    static let packagedFuel = Part.Static(id: "part-packaged-fuel")
    static let packagedLiquidBiofuel = Part.Static(id: "part-packaged-liquid-biofuel")
    static let packagedTurbofuel = Part.Static(id: "part-packaged-turbofuel")
    static let packagedAluminaSolution = Part.Static(id: "part-packaged-alumina-solution")
    static let packagedSulfuricAcid = Part.Static(id: "part-packaged-sulfuric-acid")
    static let packagedNitricAcid = Part.Static(id: "part-packaged-nitric-acid")
    static let packagedNitrogenGas = Part.Static(id: "part-packaged-nitrogen-gas")
    
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
