
extension LegacyToV2.Parts {
    static let bluePowerSlug = Migration.IDs(old: Legacy.Parts.bluePowerSlug, new: V2.Parts.bluePowerSlug)
    static let yellowPowerSlug = Migration.IDs(old: Legacy.Parts.yellowPowerSlug, new: V2.Parts.yellowPowerSlug)
    static let purplePowerSlug = Migration.IDs(old: Legacy.Parts.purplePowerSlug, new: V2.Parts.purplePowerSlug)
    
    static let powerSlugParts = [
        bluePowerSlug,
        yellowPowerSlug,
        purplePowerSlug
    ]
}
