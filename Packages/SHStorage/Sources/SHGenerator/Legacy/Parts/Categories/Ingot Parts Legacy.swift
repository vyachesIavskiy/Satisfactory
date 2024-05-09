import Models
import StaticModels

private extension Part.Static.Legacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.ingots.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let ironIngot = Part.Static.Legacy(id: "iron-ingot")
    static let copperIngot = Part.Static.Legacy(id: "copper-ingot")
    static let steelIngot = Part.Static.Legacy(id: "steel-ingot")
    static let cateriumIngot = Part.Static.Legacy(id: "caterium-ingot")
    static let aluminumIngot = Part.Static.Legacy(id: "aluminum-ingot")
    
    static let ingotParts = [
        ironIngot,
        copperIngot,
        steelIngot,
        cateriumIngot,
        aluminumIngot
    ]
}
