import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .standardParts, form: .solid)
    }
}

extension V2.Parts {
    static let ironRod = Part.Static(id: "part-iron-rod")
    static let ironPlate = Part.Static(id: "part-iron-plate")
    static let screw = Part.Static(id: "part-screw")
    static let reinforcedIronPlate = Part.Static(id: "part-reinforced-iron-plate")
    static let copperSheet = Part.Static(id: "part-copper-sheet")
    static let modularFrame = Part.Static(id: "part-modular-frame")
    static let steelBeam = Part.Static(id: "part-steel-beam")
    static let steelPipe = Part.Static(id: "part-steel-pipe")
    static let encasedIndustrialBeam = Part.Static(id: "part-encased-industrial-beam")
    static let heavyModularFrame = Part.Static(id: "part-heavy-modular-frame")
    static let alcladAluminumSheet = Part.Static(id: "part-alclad-aluminum-sheet")
    static let aluminumCasing = Part.Static(id: "part-aluminum-casing")
    
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
