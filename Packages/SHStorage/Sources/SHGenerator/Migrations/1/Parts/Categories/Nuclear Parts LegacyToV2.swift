
extension LegacyToV2.Parts {
    static let electromagneticControlRod = Migration.IDs(old: Legacy.Parts.electromagneticControlRod, new: V2.Parts.electromagneticControlRod)
    static let encasedUraniumCell = Migration.IDs(old: Legacy.Parts.encasedUraniumCell, new: V2.Parts.encasedUraniumCell)
    static let uraniumFuelRod = Migration.IDs(old: Legacy.Parts.uraniumFuelRod, new: V2.Parts.uraniumFuelRod)
    static let uraniumWaste = Migration.IDs(old: Legacy.Parts.uraniumWaste, new: V2.Parts.uraniumWaste)
    static let nonFissileUranium = Migration.IDs(old: Legacy.Parts.nonFissileUranium, new: V2.Parts.nonFissileUranium)
    static let plutoniumPellet = Migration.IDs(old: Legacy.Parts.plutoniumPellet, new: V2.Parts.plutoniumPellet)
    static let encasedPlutoniumCell = Migration.IDs(old: Legacy.Parts.encasedPlutoniumCell, new: V2.Parts.encasedPlutoniumCell)
    static let plutoniumFuelRod = Migration.IDs(old: Legacy.Parts.plutoniumFuelRod, new: V2.Parts.plutoniumFuelRod)
    static let plutoniumWaste = Migration.IDs(old: Legacy.Parts.plutoniumWaste, new: V2.Parts.plutoniumWaste)
    
    static let nuclearParts = [
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
}
