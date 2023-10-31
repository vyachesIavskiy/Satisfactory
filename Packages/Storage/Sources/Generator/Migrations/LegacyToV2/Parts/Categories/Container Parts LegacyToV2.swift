
extension LegacyToV2.Parts {
    static let emptyCanister = Migration.IDs(old: Legacy.Parts.emptyCanister, new: V2.Parts.emptyCanister)
    static let emptyFluidTank = Migration.IDs(old: Legacy.Parts.emptyFluidTank, new: V2.Parts.emptyFluidTank)
    static let pressureConversionCube = Migration.IDs(old: Legacy.Parts.pressureConversionCube, new: V2.Parts.pressureConversionCube)
    static let packagedWater = Migration.IDs(old: Legacy.Parts.packagedWater, new: V2.Parts.packagedWater)
    static let packagedOil = Migration.IDs(old: Legacy.Parts.packagedOil, new: V2.Parts.packagedOil)
    static let packagedHeavyOilResidue = Migration.IDs(old: Legacy.Parts.packagedHeavyOilResidue, new: V2.Parts.packagedHeavyOilResidue)
    static let packagedFuel = Migration.IDs(old: Legacy.Parts.packagedFuel, new: V2.Parts.packagedFuel)
    static let packagedLiquidBiofuel = Migration.IDs(old: Legacy.Parts.packagedLiquidBiofuel, new: V2.Parts.packagedLiquidBiofuel)
    static let packagedTurbofuel = Migration.IDs(old: Legacy.Parts.packagedTurbofuel, new: V2.Parts.packagedTurbofuel)
    static let packagedAluminaSolution = Migration.IDs(old: Legacy.Parts.packagedAluminaSolution, new: V2.Parts.packagedAluminaSolution)
    static let packagedSulfuricAcid = Migration.IDs(old: Legacy.Parts.packagedSulfuricAcid, new: V2.Parts.packagedSulfuricAcid)
    static let packagedNitricAcid = Migration.IDs(old: Legacy.Parts.packagedNitricAcid, new: V2.Parts.packagedNitricAcid)
    static let packagedNitrogenGas = Migration.IDs(old: Legacy.Parts.packagedNitrogenGas, new: V2.Parts.packagedNitrogenGas)
    
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
