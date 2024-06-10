import SHModels
import SHStaticModels

private extension Part.Static.Legacy {
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
    static let petroleumCoke = Part.Static.Legacy(id: "petroleum-coke")
    static let polymerResin = Part.Static.Legacy(id: "polymer-resin")
    static let rubber = Part.Static.Legacy(id: "rubber")
    static let plastic = Part.Static.Legacy(id: "plastic")
    
    static let oilProductsParts = [
        petroleumCoke,
        polymerResin,
        rubber,
        plastic
    ]
}
