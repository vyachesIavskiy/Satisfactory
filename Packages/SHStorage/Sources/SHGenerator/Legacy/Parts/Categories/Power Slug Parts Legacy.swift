import SHModels
import SHStaticModels

extension Legacy.Parts {
    static let bluePowerSlug = Part.Static.Legacy(id: "blue-power-slug")
    static let yellowPowerSlug = Part.Static.Legacy(id: "yellow-power-slug")
    static let purplePowerSlug = Part.Static.Legacy(id: "purple-power-slug")
    
    static let powerSlugParts = [
        bluePowerSlug,
        yellowPowerSlug,
        purplePowerSlug
    ]
}
