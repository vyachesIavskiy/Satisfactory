import SHModels
import SHStaticModels

private extension Part.Static.Legacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.containers.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let emptyCanister = Part.Static.Legacy(id: "empty-canister")
    static let emptyFluidTank = Part.Static.Legacy(id: "empty-fluid-tank")
    static let pressureConversionCube = Part.Static.Legacy(id: "pressure-conversion-cube")
    static let packagedWater = Part.Static.Legacy(id: "packaged-water")
    static let packagedOil = Part.Static.Legacy(id: "packaged-oil")
    static let packagedHeavyOilResidue = Part.Static.Legacy(id: "packaged-heavy-oil-residue")
    static let packagedFuel = Part.Static.Legacy(id: "packaged-fuel")
    static let packagedLiquidBiofuel = Part.Static.Legacy(id: "packaged-liquid-biofuel")
    static let packagedTurbofuel = Part.Static.Legacy(id: "packaged-turbofuel")
    static let packagedAluminaSolution = Part.Static.Legacy(id: "packaged-alumina-solution")
    static let packagedSulfuricAcid = Part.Static.Legacy(id: "packaged-sulfuric-acid")
    static let packagedNitricAcid = Part.Static.Legacy(id: "packaged-nitric-acid")
    static let packagedNitrogenGas = Part.Static.Legacy(id: "packaged-nitrogen-gas")
    
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
