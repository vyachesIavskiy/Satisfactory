import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .standardParts, form: .solid)
    }
}

extension V2.Parts {
    static let ironRod = Part(id: "part-iron-rod")
    static let ironPlate = Part(id: "part-iron-plate")
    static let screw = Part(id: "part-screw")
    static let reinforcedIronPlate = Part(id: "part-reinforced-iron-plate")
    static let copperSheet = Part(id: "part-copper-sheet")
    static let modularFrame = Part(id: "part-modular-frame")
    static let steelBeam = Part(id: "part-steel-beam")
    static let steelPipe = Part(id: "part-steel-pipe")
    static let encasedIndustrialBeam = Part(id: "part-encased-industrial-beam")
    static let heavyModularFrame = Part(id: "part-heavy-modular-frame")
    static let alcladAluminumSheet = Part(id: "part-alclad-aluminum-sheet")
    static let aluminumCasing = Part(id: "part-aluminum-casing")
    
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
