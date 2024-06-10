import SHModels
import SHStaticModels

private extension Part.Static.Legacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.powerSlugs.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

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
