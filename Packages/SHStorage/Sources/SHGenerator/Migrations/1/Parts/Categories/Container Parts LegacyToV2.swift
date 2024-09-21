
extension LegacyToV2.Parts {
    static let emptyCanister = Migration.IDs(old: Legacy.Parts.emptyCanister, new: V2.Parts.emptyCanister)
    static let emptyFluidTank = Migration.IDs(old: Legacy.Parts.emptyFluidTank, new: V2.Parts.emptyFluidTank)
    static let pressureConversionCube = Migration.IDs(old: Legacy.Parts.pressureConversionCube, new: V2.Parts.pressureConversionCube)
    
    static let containerParts = [
        emptyCanister,
        emptyFluidTank,
        pressureConversionCube,
    ]
}
