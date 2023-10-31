import StaticModels

private extension PartLegacy {
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
    static let ironIngot = PartLegacy(id: "iron-ingot")
    static let copperIngot = PartLegacy(id: "copper-ingot")
    static let steelIngot = PartLegacy(id: "steel-ingot")
    static let cateriumIngot = PartLegacy(id: "caterium-ingot")
    static let aluminumIngot = PartLegacy(id: "aluminum-ingot")
    
    static let ingotParts = [
        ironIngot,
        copperIngot,
        steelIngot,
        cateriumIngot,
        aluminumIngot
    ]
}
