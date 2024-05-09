import Models
import StaticModels

private extension Part.Static.Legacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.standartParts.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let ironRod = Part.Static.Legacy(id: "iron-rod")
    static let ironPlate = Part.Static.Legacy(id: "iron-plate")
    static let screw = Part.Static.Legacy(id: "screw")
    static let reinforcedIronPlate = Part.Static.Legacy(id: "reinforced-iron-plate")
    static let copperSheet = Part.Static.Legacy(id: "copper-sheet")
    static let modularFrame = Part.Static.Legacy(id: "modular-frame")
    static let steelBeam = Part.Static.Legacy(id: "steel-beam")
    static let steelPipe = Part.Static.Legacy(id: "steel-pipe")
    static let encasedIndustrialBeam = Part.Static.Legacy(id: "encased-industrial-beam")
    static let heavyModularFrame = Part.Static.Legacy(id: "heavy-modular-frame")
    static let alcladAluminumSheet = Part.Static.Legacy(id: "alclad-aluminum-sheet")
    static let aluminumCasing = Part.Static.Legacy(id: "aluminum-casing")
    
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
