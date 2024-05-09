import Models
import StaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .oilProducts, form: .solid)
    }
}

extension V2.Parts {
    static let petroleumCoke = Part.Static(id: "part-petroleum-coke")
    static let polymerResin = Part.Static(id: "part-polymer-resin")
    static let rubber = Part.Static(id: "part-rubber")
    static let plastic = Part.Static(id: "part-plastic")
    
    static let oilProductParts = [
        petroleumCoke,
        polymerResin,
        rubber,
        plastic
    ]
}
