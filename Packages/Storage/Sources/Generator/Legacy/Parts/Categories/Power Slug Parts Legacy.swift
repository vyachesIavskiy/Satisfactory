import StaticModels

private extension PartLegacy {
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
    static let bluePowerSlug = PartLegacy(id: "blue-power-slug")
    static let yellowPowerSlug = PartLegacy(id: "yellow-power-slug")
    static let purplePowerSlug = PartLegacy(id: "purple-power-slug")
    
    static let powerSlugParts = [
        bluePowerSlug,
        yellowPowerSlug,
        purplePowerSlug
    ]
}
