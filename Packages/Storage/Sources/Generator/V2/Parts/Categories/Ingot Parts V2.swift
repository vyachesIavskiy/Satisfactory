import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .ingots, form: .solid)
    }
}

extension V2.Parts {
    static let ironIngot = Part(id: "part-iron-ingot")
    static let copperIngot = Part(id: "part-copper-ingot")
    static let steelIngot = Part(id: "part-steel-ingot")
    static let cateriumIngot = Part(id: "part-caterium-ingot")
    static let aluminumIngot = Part(id: "part-aluminum-ingot")
    
    static let ingotParts = [
        ironIngot,
        copperIngot,
        steelIngot,
        cateriumIngot,
        aluminumIngot
    ]
}
