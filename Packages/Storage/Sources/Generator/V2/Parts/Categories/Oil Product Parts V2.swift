import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .oilProducts, form: .solid)
    }
}

extension V2.Parts {
    static let petroleumCoke = Part(id: "part-petroleum-coke")
    static let polymerResin = Part(id: "part-polymer-resin")
    static let rubber = Part(id: "part-rubber")
    static let plastic = Part(id: "part-plastic")
    
    static let oilProductParts = [
        petroleumCoke,
        polymerResin,
        rubber,
        plastic
    ]
}
