import StaticModels

private extension PartLegacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.oilProducts.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let petroleumCoke = PartLegacy(id: "petroleum-coke")
    static let polymerResin = PartLegacy(id: "polymer-resin")
    static let rubber = PartLegacy(id: "rubber")
    static let plastic = PartLegacy(id: "plastic")
    
    static let oilProductsParts = [
        petroleumCoke,
        polymerResin,
        rubber,
        plastic
    ]
}
