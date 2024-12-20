import SHModels
import SHStaticModels

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
