import Models
import StaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .ingots, form: .solid)
    }
}

extension V2.Parts {
    static let ironIngot = Part.Static(id: "part-iron-ingot")
    static let copperIngot = Part.Static(id: "part-copper-ingot")
    static let steelIngot = Part.Static(id: "part-steel-ingot")
    static let cateriumIngot = Part.Static(id: "part-caterium-ingot")
    static let aluminumIngot = Part.Static(id: "part-aluminum-ingot")
    
    static let ingotParts = [
        ironIngot,
        copperIngot,
        steelIngot,
        cateriumIngot,
        aluminumIngot
    ]
}
