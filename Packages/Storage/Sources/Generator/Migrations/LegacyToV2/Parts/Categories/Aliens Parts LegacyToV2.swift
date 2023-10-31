
extension LegacyToV2.Parts {
    static let hogRemains = Migration.IDs(old: Legacy.Parts.hogRemains, new: V2.Parts.hogRemains)
    static let plasmaSpitterRemains = Migration.IDs(old: Legacy.Parts.plasmaSpitterRemains, new: V2.Parts.plasmaSpitterRemains)
    static let stingerRemains = Migration.IDs(old: Legacy.Parts.stingerRemains, new: V2.Parts.stingerRemains)
    static let hatcherRemains = Migration.IDs(old: Legacy.Parts.hatcherRemains, new: V2.Parts.hatcherRemains)
    static let alienProtein = Migration.IDs(old: Legacy.Parts.alienProtein, new: V2.Parts.alienProtein)
    static let alienDNACapsule = Migration.IDs(old: Legacy.Parts.alienDNACapsule, new: V2.Parts.alienDNACapsule)
    
    static let alienParts = [
        hogRemains,
        plasmaSpitterRemains,
        stingerRemains,
        hatcherRemains,
        alienProtein,
        alienDNACapsule
    ]
}
