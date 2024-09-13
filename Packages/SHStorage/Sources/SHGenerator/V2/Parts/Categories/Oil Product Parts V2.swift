import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .oilProducts, form: .solid)
    }
}

extension V2.Parts {
    static let plastic = Part.Static(id: "part-plastic")
    static let rubber = Part.Static(id: "part-rubber")
    static let polymerResin = Part.Static(id: "part-polymer-resin")
    static let petroleumCoke = Part.Static(id: "part-petroleum-coke")
    
    static let oilProductParts = [
        plastic,
        rubber,
        polymerResin,
        petroleumCoke,
    ]
}
