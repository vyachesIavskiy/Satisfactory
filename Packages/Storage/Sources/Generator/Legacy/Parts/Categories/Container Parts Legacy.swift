import StaticModels

private extension PartLegacy {
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
    static let emptyCanister = PartLegacy(id: "empty-canister")
    static let emptyFluidTank = PartLegacy(id: "empty-fluid-tank")
    static let pressureConversionCube = PartLegacy(id: "pressure-conversion-cube")
    static let packagedWater = PartLegacy(id: "packaged-water")
    static let packagedOil = PartLegacy(id: "packaged-oil")
    static let packagedHeavyOilResidue = PartLegacy(id: "packaged-heavy-oil-residue")
    static let packagedFuel = PartLegacy(id: "packaged-fuel")
    static let packagedLiquidBiofuel = PartLegacy(id: "packaged-liquid-biofuel")
    static let packagedTurbofuel = PartLegacy(id: "packaged-turbofuel")
    static let packagedAluminaSolution = PartLegacy(id: "packaged-alumina-solution")
    static let packagedSulfuricAcid = PartLegacy(id: "packaged-sulfuric-acid")
    static let packagedNitricAcid = PartLegacy(id: "packaged-nitric-acid")
    static let packagedNitrogenGas = PartLegacy(id: "packaged-nitrogen-gas")
    
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
