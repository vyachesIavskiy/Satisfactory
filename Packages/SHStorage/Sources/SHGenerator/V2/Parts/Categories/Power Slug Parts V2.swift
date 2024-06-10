import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .powerSlugs, form: .solid, isNaturalResource: true)
    }
}

extension V2.Parts {
    static let bluePowerSlug = Part.Static(id: "part-blue-power-slug")
    static let yellowPowerSlug = Part.Static(id: "part-yellow-power-slug")
    static let purplePowerSlug = Part.Static(id: "part-purple-power-slug")
    
    static let powerSlugParts = [
        bluePowerSlug,
        yellowPowerSlug,
        purplePowerSlug
    ]
}
