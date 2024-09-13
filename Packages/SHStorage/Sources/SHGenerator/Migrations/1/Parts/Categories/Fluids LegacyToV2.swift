
extension LegacyToV2.Parts {
    static let water = Migration.IDs(old: Legacy.Parts.water, new: V2.Parts.water)
    static let crudeOil = Migration.IDs(old: Legacy.Parts.crudeOil, new: V2.Parts.crudeOil)
    static let heavyOilResidue = Migration.IDs(old: Legacy.Parts.heavyOilResidue, new: V2.Parts.heavyOilResidue)
    static let liquidBiofuel = Migration.IDs(old: Legacy.Parts.liquidBiofuel, new: V2.Parts.liquidBiofuel)
    static let fuel = Migration.IDs(old: Legacy.Parts.fuel, new: V2.Parts.fuel)
    static let turbofuel = Migration.IDs(old: Legacy.Parts.turbofuel, new: V2.Parts.turbofuel)
    static let aluminaSolution = Migration.IDs(old: Legacy.Parts.aluminaSolution, new: V2.Parts.aluminaSolution)
    static let sulfuricAcid = Migration.IDs(old: Legacy.Parts.sulfuricAcid, new: V2.Parts.sulfuricAcid)
    static let nitricAcid = Migration.IDs(old: Legacy.Parts.nitricAcid, new: V2.Parts.nitricAcid)
    
    static let fluidParts = [
        water,
        crudeOil,
        heavyOilResidue,
        liquidBiofuel,
        fuel,
        turbofuel,
        aluminaSolution,
        sulfuricAcid,
        nitricAcid
    ]
}
