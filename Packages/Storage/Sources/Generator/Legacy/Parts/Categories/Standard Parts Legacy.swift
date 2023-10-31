import StaticModels

private extension PartLegacy {
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
    static let ironRod = PartLegacy(id: "iron-rod")
    static let ironPlate = PartLegacy(id: "iron-plate")
    static let screw = PartLegacy(id: "screw")
    static let reinforcedIronPlate = PartLegacy(id: "reinforced-iron-plate")
    static let copperSheet = PartLegacy(id: "copper-sheet")
    static let modularFrame = PartLegacy(id: "modular-frame")
    static let steelBeam = PartLegacy(id: "steel-beam")
    static let steelPipe = PartLegacy(id: "steel-pipe")
    static let encasedIndustrialBeam = PartLegacy(id: "encased-industrial-beam")
    static let heavyModularFrame = PartLegacy(id: "heavy-modular-frame")
    static let alcladAluminumSheet = PartLegacy(id: "alclad-aluminum-sheet")
    static let aluminumCasing = PartLegacy(id: "aluminum-casing")
    
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
