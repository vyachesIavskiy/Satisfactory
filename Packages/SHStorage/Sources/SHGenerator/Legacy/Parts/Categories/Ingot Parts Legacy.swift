import SHModels
import SHStaticModels

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
