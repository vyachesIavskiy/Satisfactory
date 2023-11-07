
extension LegacyToV2.Parts {
    static let ironRod = Migration.IDs(old: Legacy.Parts.ironRod, new: V2.Parts.ironRod)
    static let ironPlate = Migration.IDs(old: Legacy.Parts.ironPlate, new: V2.Parts.ironPlate)
    static let screw = Migration.IDs(old: Legacy.Parts.screw, new: V2.Parts.screw)
    static let reinforcedIronPlate = Migration.IDs(old: Legacy.Parts.reinforcedIronPlate, new: V2.Parts.reinforcedIronPlate)
    static let copperSheet = Migration.IDs(old: Legacy.Parts.copperSheet, new: V2.Parts.copperSheet)
    static let modularFrame = Migration.IDs(old: Legacy.Parts.modularFrame, new: V2.Parts.modularFrame)
    static let steelBeam = Migration.IDs(old: Legacy.Parts.steelBeam, new: V2.Parts.steelBeam)
    static let steelPipe = Migration.IDs(old: Legacy.Parts.steelPipe, new: V2.Parts.steelPipe)
    static let encasedIndustrialBeam = Migration.IDs(old: Legacy.Parts.encasedIndustrialBeam, new: V2.Parts.encasedIndustrialBeam)
    static let heavyModularFrame = Migration.IDs(old: Legacy.Parts.heavyModularFrame, new: V2.Parts.heavyModularFrame)
    static let alcladAluminumSheet = Migration.IDs(old: Legacy.Parts.alcladAluminumSheet, new: V2.Parts.alcladAluminumSheet)
    static let aluminumCasing = Migration.IDs(old: Legacy.Parts.aluminumCasing, new: V2.Parts.aluminumCasing)
    
    static let standardParts = [
        ironRod,
        ironPlate,
        screw,
        reinforcedIronPlate,
        copperSheet,
        modularFrame,
        steelBeam,
        steelPipe,
        encasedIndustrialBeam,
        heavyModularFrame,
        alcladAluminumSheet,
        aluminumCasing
    ]
}
